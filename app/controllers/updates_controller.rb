class UpdatesController < ApplicationController
before_filter :signed_in_user, only: [:create, :destroy]

	def index
		@hist = User.find(params[:id]).updates
	end

	def create
		@update = current_user.updates.build(params[:update])
		if @update.save
			flash[:success] = "Update successfully submitted"
			redirect_to root_path # temporary until user stats page is finished user_stats_path
		else 
			flash[:error] = "Failed to update"
		end
	end

	def new
		@update = current_user.updates.build(params[:update])
	end
end
