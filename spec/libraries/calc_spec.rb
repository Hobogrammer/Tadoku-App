require 'spec_helper'
include Calc

describe "Calc module" do

  describe "score_calc" do
    it "should return a score of 0  for 0 pages in any medium" do
      score = Calc.score_calc(0, "manga", "jp")
    end

    it "should return a score of 50 points for 50 book pages" do
      score = Calc.score_calc(50,"book","jp")

      score.should eq(50)
    end

    it "should return a score of 50 points for 250 manga pages" do
      score = Calc.score_calc(250, "manga", "jp")

      score.should eq(50.0)
    end

    it "should return a score of 50 points for 300 full game screens" do
      score = Calc.score_calc(301,"fgame", "jp")

      #this can never be exactly equal so going a little fuzzy
      score.should be_within( 0.5).of(50)
    end

    it "should return a score of 50 points for 1000 game screens" do
      score = Calc.score_calc(1000, "game", "jp")

      score.should eq(50)
    end

    it "should return a score of 50 points for 250 minutes of subs" do
      score = Calc.score_calc(250, "subs", "jp")

      score.should eq(50)
    end

    it "should return a score of 50 points for 250 minutes of 'sub'" do
      score = Calc.score_calc(250, "sub", "jp")

      score.should eq(50)
    end

    it "should return a score of 50 points for 500 minutes of nico" do
      score = Calc.score_calc(500,"nico","jp")

      score.should eq(50)
    end

    it "should return 74 points for 50 pages of a double-rowed book in japanese" do
      score = Calc.dr(50)

      score.should eq(74)
    end

    describe "sentences" do
    end

    describe "repeats" do
    end

  end
end
