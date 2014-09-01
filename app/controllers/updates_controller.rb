class UpdatesController < ApplicationController
  include ApplicationHelper,Tweet

  before_filter :signed_in_user, only: :create
  before_filter :correct_user, only: :destroy
  before_filter :admin_user, only: [:destroy, :edit]

  def create
    current_user_round = Round.registration_check(current_user)
    if current_user_round
      client = Update.initialize_twitter

      @update = current_user.updates.build(update_params)
      @update.round_id = ApplicationHelper.curr_round


      @update = Update.process_update(@update,  current_user_round)

      if @update.save
        ApplicationHelper.medium_update(current_user,round,@update.medium,@update.raw,new_read,new_total)
        Tweet.tweet_up(current_user,new_total.round(2),Round.rank(current_user,round),client)

        flash[:success] = "Update successfully submitted"
        redirect_to round_path(ApplicationHelper.curr_round)
      else
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
    Update.undo_update(@update,current_user)

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
