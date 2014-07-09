class UsersController < ApplicationController
  before_filter :admin_user, only: [:destroy, :edit]

  def show
    @user = User.find(params[:id])
    @max_interval= Date.civil(ApplicationHelper.curr_round[0,4].to_i,ApplicationHelper.curr_round[4,6].to_i,-1).day
    @update = build_update

    if !@user.rounds.find_by_round_id(ApplicationHelper.curr_round).nil?
      @round_stats = Calc.usermed_info(@user,ApplicationHelper.curr_round)
      @round = @user.rounds.find_by_round_id(ApplicationHelper.curr_round)
      @updates = @user.updates.where(:round_id => ApplicationHelper.curr_round).order('created_at DESC').limit(10)
    else
      flash[:error] = "This user is not registered for the current round. For past round records please  access the old rankings."
      redirect_to ranking_path
    end
  end

  def old_show
    @user = User.find(params[:user_id])

    @round_id = params[:round_id]
    @max_interval = Date.civil(@round_id[0,4].to_i,@round_id[4,6].to_i,-1).day
    @update = build_update

    if !@user.rounds.find_by_round_id(params[:round_id]).nil?
      @round_stats = Calc.usermed_info(@user,params[:round_id])
      @round = @user.rounds.find_by_round_id(params[:round_id])
      @updates = @user.updates.where(:round_id => params[:round_id]).order('created_at DESC').limit(10)
    else
      flash[:error] = "This user is not registered for this round."
      redirect_to ranking_path
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

    @update = build_update
  end

  private

  def user_params
    params.require(:user).permit(:name, :provider, :uid, :time_zone, :avatar)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
