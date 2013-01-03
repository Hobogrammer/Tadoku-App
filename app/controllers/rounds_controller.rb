class RoundsController < ApplicationController
	include ApplicationHelper
	include SessionsHelper
	before_filter :signed_in_user, only: :create
	before_filter :admin_user, only: [:destroy, :edit]


	def index
		@entrants = Round.includes(:user).where(:round_id => "#{ApplicationHelper::curr_round}")
		if @entrants == nil
			redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
		end
		
		if signed_in?
  			@update = current_user.updates.build
  		end
	end

	def create
		if current_user.rounds.find_by_round_id(ApplicationHelper::curr_round) != nil
			redirect_to root_url, :flash => { :error => "You are already registered for the Contest"}
		else
			@reg = current_user.rounds.build(params[:round])
			@reg.pcount = '0'
			if @reg.save
				redirect_to root_url, :flash => { :success => "You have successfully registered for the Tadoku contest" }
			end
		end
	end



	private
	
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end