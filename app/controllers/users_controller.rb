class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		if signed_in?
  			@update = current_user.updates.build
  		end
	end

	def index
	end
end
