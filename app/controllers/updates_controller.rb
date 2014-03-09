class UpdatesController < ApplicationController
  include ApplicationHelper, Calc, Tweet

  before_filter :signed_in_user, only: :create
  before_filter :correct_user, only: :destroy
  before_filter :admin_user, only: [:destroy, :edit]

  def create
    if !current_user.rounds.find_by_round_id(ApplicationHelper::curr_round).nil?
      client = Twitter::Client.new

      @update = current_user.updates.build(params[:update])
      round = ApplicationHelper::curr_round.to_s
      @update.round_id = round

      if @update.newread == '0.0' || @update.lang.empty? || @update.medium.empty?
        flash[:error] = "Pages read, language, and medium MUST be included. Please provide all the information and try again."
        redirect_to ranking_path
      else
        @update.raw = @update.newread
        @update.recpage = current_user.rounds.find_by_round_id(round).pcount
        new_read = Calc::score_calc(@update.newread, @update.medium, @update.lang)

        #Don't like all these if statements, might try to add it to the score_calc function.
        new_read = Calc::dr(new_read) if @update.dr == true

        @update.raw = Calc::dr(@update.raw) if @update.dr == true

        new_read = Calc::repeat(new_read, @update.repeat) if (@update.repeat > 0)
        @update.raw = Calc::repeat(@update.raw, @update.repeat) if (@update.repeat > 0)

        @update.newread = new_read
        new_total = new_read + @update.recpage

        @update.created_at_in_user_time = ApplicationHelper::convert_usr_time(current_user,Time.now)
        if @update.save

          ApplicationHelper::medium_update(current_user,round,@update.medium,@update.raw,new_read,new_total)
          rank = Round::rank(current_user,round)
          Tweet::tweet_up(current_user,new_total.round(2),rank,client)

          flash[:success] = "Update successfully submitted"
          redirect_to ranking_path
        else
          flash[:error] = "Failed to update"
        end
      end
    else
      flash[:error] = "You must be registered for the current round in order to submit an update. Please register"
      redirect_to root_path
    end
  end

  def new
    @update = current_user.updates.build(params[:update])
  end

  def destroy
    unread = @update.raw.to_f
    unmed = @update.medium.to_s
    usr_round = current_user.rounds.find_by_round_id(ApplicationHelper::curr_round)

    rev_total = usr_round.pcount.to_f - @update.newread.to_f
    old_med_read = usr_round.send(unmed).to_f
    rev_med_read = old_med_read.to_f - unread.to_f
    usr_round.update_attributes(unmed.to_sym => rev_med_read)

    usr_round.update_attributes(:pcount => rev_total)
    @update.destroy

    flash[:success] = "Update undo successful."
    redirect_to ranking_path
  end

  private

    def correct_user
      @update = current_user.updates.find_by_id(params[:id])
      redirect_to(root_path) if  @update.nil?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
