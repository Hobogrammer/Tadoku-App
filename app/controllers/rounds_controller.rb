class RoundsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  before_filter :signed_in_user, only: :create
  before_filter :admin_user, only: [:destroy, :edit]

  def index

  end

  def create
    if !current_user.rounds.find_by_round_id(ApplicationHelper.curr_round).present?
      redirect_to root_url, :flash => { :error => "You are already registered for the Contest"}
    elsif !round_params["round_id"].present?
      redirect_to root_url, :flash => { :error => "Please fill in the Round ID, and at least one language to register."}
    else
      @reg = current_user.rounds.build(round_params)
      @reg.pcount = '0'
      if current_user.rounds.find_by_round_id(1).nil?
        @over_reg = current_user.rounds.build(:round_id => 1, :pcount => 0)
        @over_reg.save
        @reg.tier = "Bronze"
      else
        usr_total = current_user.rounds.find_by_round_id(1).pcount.to_f
        tier = Tier.tier(usr_total)
        @reg.tier = tier
      end

      if @reg.save
        redirect_to root_url, :flash => { :success => "You have successfully registered for the Tadoku contest" }
      end
    end
  end

  def show
    @round_id = params[:id]
    @entrants = Round.includes(:user).where(:round_id => @round_id)
    if @entrants == nil
      redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
    end

    list = Round.where(:round_id => @round_id).select(:tier).uniq
    lang_list = Update.where(:round_id => @round_id).select(:lang).uniq
    @tier = list.map(&:tier)
    @tier = @tier.sort{ |a,b|  Tier::TIER_VALUES[a.to_sym] <=> Tier::TIER_VALUES[b.to_sym]}
    @lang = lang_list.map(&:lang)

    @update = current_user.updates.build if signed_in?

    redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." } if !@entrants.present?
  end

  def lang_show
    lang_users = Round.includes(:user).where("round_id = ? and (lang1 = ? or lang2 = ? or lang3 = ?)", params[:round_id], params[:lang], params[:lang], params[:lang])

    lang_top =Hash.new

    lang_users.each do |entrant|
      total = 0
      langups = entrant.user.updates.where(:round_id => params[:round_id], :lang => params[:lang]).select("sum(newread) as  accum")
      total= langups.map(&:accum)
      total = total.first.to_f
      lang_top["#{entrant.user.name}"] = total
    end

    @lang_sort = lang_top.sort_by {|k,v| v  || 0}
    @lang_sort = @lang_sort.reverse
    binding.pry

    @roundid = params[:round_id]
    @lang = params[:lang]
    @update = current_user.updates.build if signed_in?

    redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." } if !lang_users.present?

  end

  def round0_show
    @entrants = Round.includes(:user).where(:round_id => 201008)
  end

  def tier_show
    @entrants = Round.includes(:user).where("round_id = ? and tier = ?", params[:round_id], params[:tier])
    @roundid = params[:round_id]
    @tier = params[:tier]
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
