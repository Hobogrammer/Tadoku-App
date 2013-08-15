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
      tier = "Jasmium"
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
end
