class ViewPagesController < ApplicationController

  
  def home
  		if signed_in?
  			@update = current_user.updates.build
  			@reg = current_user.rounds.build
      if !current_user.rounds.find_by_round_id(ApplicationHelper::curr_round).nil?
        redirect_to ranking_path
      end
  		end
  end

  def about
    if signed_in?
        @update = current_user.updates.build
    end
  end

  def manual
    if signed_in?
        @update = current_user.updates.build
    end
  end
end
