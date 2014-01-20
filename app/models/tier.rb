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
    when (10000...14999) 
      tier = "Gundanium"
    when (15000...19999)
      tier = "Adamantium"
    when (20000..24999)
      tier = "Tiberium"
    when (25000..29999)
      tier = "Eridium"
    when (30000...34999)
      tier = "Illithium"
    when (35000..39999)
      tier = "Jasminum"
    when (40000..44999)
      tier ="Necrodermis"
    when (45000..49999)
      tier = "Stravidium"
    when (50000..59999)
      tier = "Melange"
    when (60000..69999)
      tier = "Yuanon"
    when (70000..1000000)
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
