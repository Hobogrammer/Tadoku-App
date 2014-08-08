class UpdatesController < ApplicationController
  include ApplicationHelper, Calc, Tweet

  before_filter :signed_in_user, only: :create
  before_filter :correct_user, only: :destroy
  before_filter :admin_user, only: [:destroy, :edit]

  def create
    current_user_round = Round.registration_check(current_user)
    if current_user_round
      client = Update.initialize_twitter

      @update = current_user.updates.build(update_params)
      @update.round_id = ApplicationHelper.curr_round

      @update.raw , @update.recpage = @update.newread, current_user_round.pcount
      new_read = Calc.score_calc(@update.newread, @update.medium, @update.lang)

      if @update.dr == true
        new_read = Calc.dr(new_read)
        @update.raw = Calc.dr(@update.raw)
      end

      if @update.repeat > 0
        new_read = Calc.repeat(new_read, @update.repeat)
        @update.raw = Calc.repeat(@update.raw, @update.repeat)
      end

      @update.newread = new_read
      new_total = new_read + @update.recpage

      @update.created_at_in_user_time = ApplicationHelper.convert_usr_time(current_user,Time.now)
      if @update.save
        ApplicationHelper.medium_update(current_user,round,@update.medium,@update.raw,new_read,new_total)
        Tweet.tweet_up(current_user,new_total.round(2),Round.rank(current_user,round),client)

        flash[:success] = "Update successfully submitted"
        redirect_to round_path(ApplicationHelper.curr_round)
      else
        binding.pry
        flash[:error] = "Failed to update. Please make sure all required fields are filled in."
        redirect_to round_path(ApplicationHelper.curr_round)
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
    undo_read_amount, undo_med = @update.raw.to_f , @update.medium
    usr_round = current_user.rounds.find_by_round_id(ApplicationHelper.curr_round)

    revised_total = usr_round.pcount.to_f - @update.newread.to_f
    old_med_read = usr_round.send(undo_med).to_f
    revised_med_read = old_med_read.to_f - undo_read_amount.to_f
    usr_round.update_attributes(undo_med.to_sym => revised_med_read)

    usr_round.update_attributes(:pcount => revised_total)
    @update.destroy

    flash[:success] = "Update undo successful."
    redirect_to round_path(ApplicationHelper.curr_round)
  end

  private

  def update_params
    params.require(:update).permit(:raw, :medium, :newread, :recpage, :round_id, :lang, :dr, :repeat, :created_at_in_user_time)
  end

  def correct_user
    @update = current_user.updates.find_by_id(params[:id])
    redirect_to(root_path) if  @update.nil?
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
