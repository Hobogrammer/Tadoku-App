class UpdatesController < ApplicationController
	include ApplicationHelper, Calc, Tweet


before_filter :signed_in_user, only: [:create, :destroy]

	def index
		@hist = User.find(params[:id]).updates
	end

	def create

		client = Twitter::Client.new

		@update = current_user.updates.build(params[:update])
		round = ApplicationHelper::curr_round.to_s
		@update.round_id = round
		@update.recpage = current_user.rounds.find_by_round_id(round).pcount
		new_read = Calc::score_calc(@update.newread, @update.medium, @update.lang)
		
#Don't like all these if statements, might try to add it to the score_calc function.
		new_read = Calc::dr(new_read) if @update.dr == true

		new_read = Calc::repeat(new_read, @update.repeat) if (@update.repeat > 0)

		@update.newread = new_read
		new_total = new_read + @update.recpage

		current_user.rounds.find_by_round_id(round).update_attributes(:pcount => new_total)

		#Tweet::tweet_up(current_user,new_total,client)

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
