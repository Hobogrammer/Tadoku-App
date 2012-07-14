class RoundsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]

	def ranking
	end

	def create
		if current_user.rounds.find_by_round_id(params[:round_id]) != nil
			redirect_to root_url, :flash => { :error => "You are already registered for the Contest"}
		else
			@round = current_user.rounds.build(:round_id => params[:round_id])
			if @round.save
				redirect_to root_url, :flash => { :success => "You have successfully registered for the Tadoku contest" }
			end
		end
	end
end
