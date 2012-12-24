class UsersController < ApplicationController
	before_filter :admin_user, only: [:destroy, :edit]

	def show
		@user = User.find(params[:id])
		if signed_in?
  			@update = current_user.updates.build
  		end

  		@round_stats = @user.rounds.find_by_round_id(ApplicationHelper::curr_round)
  		@updates = @user.updates.where(:round_id => ApplicationHelper::curr_round).limit(10)
	end

	def index
	end

	private
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end