class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  include SessionsHelper

  before_filter :previous_rounds

  def previous_rounds
    Round.previous_rounds
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
