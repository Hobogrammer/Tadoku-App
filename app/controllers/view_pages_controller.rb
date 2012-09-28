class ViewPagesController < ApplicationController
  
  
  def home
  		if signed_in?
  			@update = current_user.updates.build
  			@reg = current_user.rounds.build
  		end
  end

  def about
  end

  def manual
  end
end
