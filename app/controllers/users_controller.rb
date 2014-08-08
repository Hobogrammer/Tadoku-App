class UsersController < ApplicationController
  before_filter :admin_user, only: [:destroy, :edit]

  def show
    @user = User.find(params[:user_id])
    @round_id = params[:round_id]
    @update = ApplicationHelper.build_update(signed_in?)

    if !@user.rounds.find_by_round_id(@round_id).nil?
      @round_stats = Calc.usermed_info(@user,@round_id)
      @round = @user.rounds.find_by_round_id(@round_id)
      @avg = Calc.month_reading_average(@user, @round_id, @round.pcount)
      @updates = @user.updates.where(:round_id => @round_id).order('created_at DESC').limit(10)
    else
      flash[:error] = "This user is not registered for the selected round."
      redirect_to round_path(ApplicationHelper.curr_round)
    end
  end

  def profile
    @user = User.find(params[:user_id])
    @rounds_list = @user.rounds.all
    @rounds_stats = Hash.new

    @rounds_list.each do |round|
      round_stats = Calc.usermed_info(@user, round.round_id)
      @rounds_stats["#{round.round_id}"] = round_stats
    end
    @rounds_stats.keep_if { |k,v| k.to_f != 0 }

    @update = ApplicationHelper.build_update(signed_in?)
  end

  private

  def user_params
    params.require(:user).permit(:name, :provider, :uid, :time_zone, :avatar)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
