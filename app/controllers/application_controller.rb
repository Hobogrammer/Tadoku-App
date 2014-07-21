class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  include SessionsHelper

  before_filter :previous_rounds

  def previous_rounds
    round_list = ApplicationHelper.prev_rounds
    year_list = years
    round_hash = seed_round_hash(year_list)

    round_list.each do |round|
      year_list.each do |year|
        round_hash["#{year}"] << round if round.match(/"#{year}".+/)
      end
    end

    round_hash do { |x| x.sort }

    @ordered_rounds = {"2011" => rounds_2011.sort, "2012" => rounds_2012.sort, "2013" => rounds_2013.sort, "2014" => old_rounds.sort }
    #TODO: make this more automatic
  end

  def years
    year_list = []
    start_year = 2010
    current_year = Date.today.year
    while start_year <= current_year
      year_list << start_year
      start_year += 1
    end
    year_list
  end

  def seed_round_hash(year_list)
    round_hash = {}
    year_list.each do |year|
      round_hash["#{year}"] = []
    end
    round_hash
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
