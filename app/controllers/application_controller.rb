class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  include SessionsHelper

  before_filter :previous_rounds

  def previous_rounds
    old_rounds = ApplicationHelper::prev_rounds()
    rounds_2011 = old_rounds.dup
    rounds_2012 = old_rounds.dup
    rounds_2013 = old_rounds.dup
    rounds_2011.keep_if { |x| x.to_s =~ /2011.+/ }
    rounds_2012.keep_if { |x| x.to_s =~ /2012.+/ }
    rounds_2013.keep_if { |x| x.to_s =~ /2013.+/ }
    old_rounds.keep_if { |x| x.to_s =~ /2014.+/ }

    @ordered_rounds = {"2011" => rounds_2011.sort, "2012" => rounds_2012.sort, "2013" => rounds_2013.sort, "2014" => old_rounds.sort }
    #TODO: make this more automatic
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
