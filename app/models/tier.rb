class Tier < ActiveRecord::Base
   attr_accessible :title, :body

def self.tier (pagecount)

  case pagecount
  when (0..999)
    tier = "Bronze"
  when (1000..2999)
    tier = "Silver"
  when (3000..5499)
    tier = "Gold"
  when (5500...9999) 
    tier = "Gundanium"
  when (10000...14999)
    tier = "Adamantium"
  when (15000..19999)
    tier = "Tiberium"
  when (20000..24999)
    tier = "Eridium"
  when (25000..29999)
    tier = "Spice"
  end
end

end
