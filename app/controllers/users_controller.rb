class UsersController < ApplicationController
	before_filter :admin_user, only: [:destroy, :edit]

	def show
		@user = User.find(params[:id])
           @last_day = Date.civil(ApplicationHelper::curr_round[0,4].to_i,ApplicationHelper::curr_round[4,6].to_i,-1).day.to_i
		if signed_in?
  			@update = current_user.updates.build
  		end

  		if !@user.rounds.find_by_round_id(ApplicationHelper::curr_round).nil?
  			@round_stats = Calc::usermed_info(@user,ApplicationHelper::curr_round)
  			@round = @user.rounds.find_by_round_id(ApplicationHelper::curr_round)
  			@updates = @user.updates.where(:round_id => ApplicationHelper::curr_round).order('created_at DESC').limit(10)
  		else
  			flash[:error] = "This user is not registered for the current round, for past round records please use access the old rankings."
  			redirect_to ranking_path
  		end
	end

    def old_show
      @user = User.find(params[:user_id])
      @round_id = params[:round_id] 
      @last_day = Date.civil(@round_id[0,4].to_i,@round_id[4,6].to_i,-1).day.to_i
      
      if signed_in?
        @update = current_user.updates.build
      end


      if !@user.rounds.find_by_round_id(params[:round_id]).nil?
        @round_stats = Calc::usermed_info(@user,params[:round_id])
        @round = @user.rounds.find_by_round_id(params[:round_id])
        @updates = @user.updates.where(:round_id => params[:round_id]).order('created_at DESC').limit(10)
      else
        flash[:error] = "This user is not registered for the current round, for past round records please use access the old rankings."
        redirect_to ranking_path
      end
    end

	private
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end