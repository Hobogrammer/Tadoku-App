class Tier < ActiveRecord::Base
   attr_accessible :title, :body

  TIER_VALUES = {:Bronze=>0, :Silver=>1, :Gold=>2, :Gundanium=>3,
    :Adamantium=>4, :Tiberium=>5, :Eridium=>6, :Illithium=>7,
    :Jasminum=>8, :Necrodermis=>9, :Stravidium=>10,
    :Melange=>11,:Yuanon=>12,:DarkMatter=>13}

  def self.tier (pagecount)

    case pagecount
    when (0..999)
      tier = "Bronze"
    when (1000..4999)
      tier = "Silver"
    when (5000..9999)
      tier = "Gold"
    when (10000...15999)
      tier = "Gundanium"
    when (16000...22999)
      tier = "Adamantium"
    when (23000..30999)
      tier = "Tiberium"
    when (31000..39999)
      tier = "Eridium"
    when (40000...49999)
      tier = "Illithium"
    when (50000..60999)
      tier = "Jasminum"
    when (61000..72999)
      tier ="Necrodermis"
    when (73000..85999)
      tier = "Stravidium"
    when (86000..99999)
      tier = "Melange"
    when (100000..114999)
      tier = "Yuanon"
    when (115000..1000000)
      tier = "DarkMatter"
    end
  end

  def self.tier_correct
    user_list = User.all

    user_list.each do |user|
      user_round = user.rounds.find_by_round_id(ApplicationHelper::curr_round)
      if user_round.nil?
        next
      else
        user_total = user.rounds.find_by_round_id(1).pcount.to_f
      end

      if user_total.nil?
        next
      else
        user_tier = Tier.tier(user_total)
      end
      puts "Old tier #{user_round.tier.to_s}"
      puts "New tier #{user_tier}"
      user_round.update_attributes(:tier => user_tier)
    end
  end
end
