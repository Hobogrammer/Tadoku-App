class RoundsController < ApplicationController
	include ApplicationHelper
	include SessionsHelper
	before_filter :signed_in_user, only: [:create, :destroy]


	def index
		@entrants = Round.includes(:user).where(:round_id => "#{curr_round()}")
		if @entrants == nil
			redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
		end
		
		if signed_in?
  			@update = current_user.updates.build
  		end
	end

	def create
		if current_user.rounds.find_by_round_id(curr_round()) != nil
			redirect_to root_url, :flash => { :error => "You are already registered for the Contest"}
		else
			@reg = current_user.rounds.build(params[:round])
			if @reg.save
				redirect_to root_url, :flash => { :success => "You have successfully registered for the Tadoku contest" }
			end
		end
	end

	def new
	end
end
