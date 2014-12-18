class Round < ActiveRecord::Base
  belongs_to :user

  validates :round_id, presence: true
  validates :user_id, presence: true

 default_scope { order( :pcount => :desc ) }

  def self.rank(user,roundid) # TODO: Make this more efficient...just cause
    part_list = Round.where(:round_id => roundid)

    i = 1
    part_list.each do |list|
      if (user.id == list.user_id)
        return i
      end
      i += 1
    end
  end

  def self.registraton_check(user)
     current_user_round = user.rounds.find_by_round_id(ApplicationHelper.curr_round)

     if current_user_round
      current_user_round
    else
      false
    end
  end

  def self.ranking_by_lang(round_id, lang)
    lang_users = Round.includes(:user).where("round_id = ? and (lang1 = ? or lang2 = ? or lang3 = ?)", round_id, lang, lang, lang)

    lang_top = Hash.new

    lang_users.each do |entrant|
      total = 0
      
      entrant_lang_updates = entrant.user.updates.where(:round_id => round_id, :lang => lang).select("sum(newread) as  accum")
      
      total = entrant_lang_updates.map(&:accum).first.to_f

      lang_top["#{entrant.user.name}"] = total
    end

    lang_top = lang_top.sort_by {|k,v| v  || 0}.reverse
  end

  def self.tiers_for_round(round_id)
    tiers = Round.where(:round_id => @round_id).select(:tier).uniq.map(&:tier)
    tiers.sort{ |a,b|  Tier::TIER_VALUES[a.to_sym] <=> Tier::TIER_VALUES[b.to_sym]}
  end

  def self.langs_for_round(round_id)
    Update.where(:round_id => @round_id).select(:lang).uniq.map(&:lang)
  end

  def self.users_for_round(round_id)
    Round.includes(:user).where(:round_id => @round_id)
  end

  def self.users_by_round_tier(round_id,tier)
    Round.includes(:user).where("round_id = ? and tier = ?", round_id, tier)
  end
end
