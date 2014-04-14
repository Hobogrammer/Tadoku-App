require 'spec_helper'

describe Tier do

  describe "returning a tier from a given a page count" do

    it "returns 'Bronze' for < 999" do
      tier = Tier.tier(500)

      tier.should eq "Bronze"
    end

    it "returns 'Bronze' for = 999" do
      tier = Tier.tier(999)

      tier.should eq "Bronze"
    end

    it "returns 'Bronze' for 999.4" do
      tier = Tier.tier(999.4)

      tier.should eq "Bronze"
    end

    it "returns 'Silver' for 999.5" do
      tier = Tier.tier(999.5)

      tier.should eq "Silver"
    end

    it "returns 'Silver' for 1000" do
      tier = Tier.tier(1000)

      tier.should eq "Silver"
    end

    it "returns 'Silver' for <= 4999" do
      tier = Tier.tier(4999)

      tier.should eq "Silver"
    end

    it "returns 'Gold' for 5000" do
      tier = Tier.tier(5000)

      tier.should eq "Gold"
    end

    it "returns 'Gold' for <= 9999" do
      tier = Tier.tier(9999.4)

      tier.should eq "Gold"
    end

    it "returns 'Gundanium' for 10000" do
      tier = Tier.tier(10000)

      tier.should eq "Gundanium"
    end

    it "returns 'Gundanium' for <= 15999" do
      tier = Tier.tier(15999)

      tier.should eq "Gundanium"
    end

    it "returns 'Adamantium' for 16000" do
      tier = Tier.tier(16000)

      tier.should eq "Adamantium"
    end

    it "returns 'Adamantium' for <= 22999" do
      tier = Tier.tier(22999.3)

      tier.should eq "Adamantium"
    end

    it "returns 'Tiberium' for 23000" do
      tier = Tier.tier(23000)

      tier.should eq "Tiberium"
    end

    it "returns 'Tiberium' for <= 30999" do
      tier = Tier.tier(30999)

      tier.should eq "Tiberium"
    end

    it "returns 'Eridium' for 31000" do
      tier = Tier.tier(31000)

      tier.should eq "Eridium"
    end

    it "returns 'Eridium' for <= 39999" do
      tier = Tier.tier(39999.4)

      tier.should eq "Eridium"
    end

    it "returns 'Illithium' for 40000" do
      tier = Tier.tier(40000)

      tier.should eq "Illithium"
    end

    it "returns 'Illithium' for <= 49999" do
      tier = Tier.tier(49999)

      tier.should eq "Illithium"
    end

    it "returns 'Jasminum' for 50000" do
      tier = Tier.tier(50000)

      tier.should eq "Jasminum"
    end

    it "returns 'Jasminum' for <= 60999" do
      tier = Tier.tier(60999)

      tier.should eq "Jasminum"
    end

    it "returns 'Necrodermis' for 61000" do
      tier = Tier.tier(61000)

      tier.should eq "Necrodermis"
    end

    it "returns 'Necrodermis' for <= 72999" do
      tier = Tier.tier(72999.2)

      tier.should eq "Necrodermis"
    end

    it "returns 'Stravidium' for 73000" do
      tier = Tier.tier(73000)

      tier.should eq "Stravidium"
    end

    it "returns 'Stravidium' for <= 85999" do
      tier = Tier.tier(85999)

      tier.should eq "Stravidium"
    end

    it "returns 'Melange' for 86000" do
      tier = Tier.tier(86000)

      tier.should eq "Melange"
    end

    it "returns 'Melange' for <= 99999" do
      tier = Tier.tier(99999.4)

      tier.should eq "Melange"
    end

    it "returns 'Yuanon' for 100000" do
      tier = Tier.tier(100000)

      tier.should eq "Yuanon"
    end

    it "returns 'Yuanon' for <= 114999" do
      tier = Tier.tier(114999)

      tier.should eq "Yuanon"
    end

    it "returns 'DarkMatter' for >= 115000" do
      tier = Tier.tier(118111)

      tier.should eq "DarkMatter"
    end
  end
end
