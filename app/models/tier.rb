class Tier < ActiveRecord::Base
   attr_accessible :title, :body

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
      tier = "Dark Matter"
    end
  end
end
