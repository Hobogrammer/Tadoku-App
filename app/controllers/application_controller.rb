class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  include SessionsHelper

  before_filter :previous_rounds

  def previous_rounds
    round_list = ApplicationHelper.prev_rounds
    year_list = years
    @ordered_rounds = seed_round_hash(year_list)

    round_list.each do |round|
      year_list.each do |year|
        @ordered_rounds["#{year}"] << round if round.to_s.match(/#{year}.+/)
      end
    end
    @ordered_rounds.each { |k,v| @ordered_rounds[k] = v.sort }
  end

  def years
    start_year = 2010
    current_year = Date.today.year
    year_list = (start_year..current_year).to_a
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
