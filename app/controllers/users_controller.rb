class UsersController < ApplicationController
	before_filter :admin_user, only: [:destroy, :edit]

	def show
		@user = User.find(params[:id])
		if signed_in?
  			@update = current_user.updates.build
  		end

  		if !@user.rounds.find_by_round_id(ApplicationHelper::curr_round).nil?
  			@round_stats = Calc::usermed_info(@user,ApplicationHelper::curr_round)
  			@round = @user.rounds.find_by_round_id(ApplicationHelper::curr_round)
  			@updates = @user.updates.where(:round_id => ApplicationHelper::curr_round).limit(10)
  			@updates = @updates.reverse
  		else
  			flash[:error] = "This user is not registered for the current round, for past round records please use access the old rankings."
  			redirect_to ranking_path
  		end
	end

	def index
	end

	private
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end