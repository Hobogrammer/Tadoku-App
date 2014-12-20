class RoundsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  before_filter :signed_in_user, only: :create
  before_filter :admin_user, only: [:destroy, :edit]

  def create
    if !current_user.rounds.find_by_round_id(ApplicationHelper.curr_round).present?
      redirect_to root_url, :flash => { :error => "You are already registered for the Contest"}
    elsif !round_params["round_id"].present?
      redirect_to root_url, :flash => { :error => "Please fill in the Round ID, and at least one language to register."}
    else
      @reg = Round.build_user_round(current_user, round_params)
      
      if @reg.save
        redirect_to root_url, :flash => { :success => "You have successfully registered for the Tadoku contest" }
      end
    end
  end

  def show
    @round_id = params[:id]
    @entrants = Round.users_for_round(@round_id)

     redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." } if entrants.nil?

    @tier =  Round.tiers_for_round(@round_id)
    @lang = Round.langs_for_round(@round_id)
    @update = current_user.updates.build if signed_in?

    redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." } if !@entrants.present?
  end

  def lang_show
    @lang_sort = Round.ranking_by_lang(params[:round_id],params[:lang])
    
    @roundid = params[:round_id]
    @lang = params[:lang]
    @update = current_user.updates.build if signed_in?

    redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." } if !lang_users.present?
  end

  def round0_show
    @entrants = Round.users_for_round(201008)
  end

  def tier_show
    @round_id = params[:round_id]
    @tier = params[:tier]
    @entrants = Round.users_by_round_tier(@round_id, @tier)
    if signed_in?
      @update = current_user.updates.build #This should probably be a helper function called by a before_filter
    end

    if !@entrants.present?
      redirect_to root_url, :flash => { :error => "There are no users in this tier registered for this round." } #This pattern appears 3 times, extract
    end
  end

  private

  def round_params
    params.require(:round).permit(:book, :fgame, :game, :gmet, :goal, :lang1, :lang2, :lang3, :lyric, :manga, :net, :news, :nico, :pcount, :round_id, :sent, :subs, :tier)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
