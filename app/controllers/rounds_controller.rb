class RoundsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  before_filter :signed_in_user, only: :create
  before_filter :admin_user, only: [:destroy, :edit]


  def index
    @entrants = Round.includes(:user).where(:round_id => "#{ApplicationHelper::curr_round}")
    if @entrants == nil
      redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
    end

    list = Round.where(:round_id => ApplicationHelper::curr_round).select(:tier).uniq
    lang_list = Update.where(:round_id => ApplicationHelper::curr_round).select(:lang).uniq
    @tier = list.map(&:tier)
    @tier = @tier.sort{ |a,b|  Tier::TIER_VALUES[a.to_sym] <=> Tier::TIER_VALUES[b.to_sym]}
    @lang = lang_list.map(&:lang)
    if signed_in?
      @update = current_user.updates.build
    end
  end

  def create
    if current_user.rounds.find_by_round_id(ApplicationHelper::curr_round) != nil
      redirect_to root_url, :flash => { :error => "You are already registered for the Contest"}
    else
      @reg = current_user.rounds.build(params[:round])
      @reg.pcount = '0'
      if current_user.rounds.find_by_round_id(1).nil?
        @over_reg = current_user.rounds.build(:round_id => 1, :pcount => 0)
        @over_reg.save
        @reg.tier = "Bronze"
      else 
        usr_total = current_user.rounds.find_by_round_id(1).pcount.to_f
        tier = Tier::tier(usr_total)
        @reg.tier = tier
      end

      if @reg.save
        redirect_to root_url, :flash => { :success => "You have successfully registered for the Tadoku contest" }
      end
    end
  end

  def show
    @entrants = Round.includes(:user).where(:round_id => params[:id])
    @roundid = params[:id]
    if signed_in?
      @update = current_user.updates.build
    end

    if (@entrants.empty? | @entrants.nil?)
      redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
    end
  end

  def lang_show
    @entrants = Round.includes(:user).where("round_id = ? and (lang1 = ? or lang2 = ? or lang3 = ?)", params[:round_id], params[:lang], params[:lang], params[:lang])


    @roundid = params[:round_id]
    @lang = params[:lang]
    if signed_in?
      @update = current_user.updates.build
    end

    if (@entrants.empty? | @entrants.nil?)
      redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
    end
  end

  def round0_show
    @entrants = Round.includes(:user).where(:round_id => 201008)
  end

  def tier_show
    @entrants = Round.includes(:user).where("round_id = ? and tier = ?", params[:round_id], params[:tier])
    @roundid = params[:round_id]
    @tier = params[:tier]
    if signed_in?
      @update = current_user.updates.build
    end

    if (@entrants.empty? | @entrants.nil?)
      redirect_to root_url, :flash => { :error => "There are no users in this tier registered for this round." }
    end
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end