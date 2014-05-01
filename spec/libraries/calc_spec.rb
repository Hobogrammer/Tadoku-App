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

    describe "Sentences" do
      it "should return 5 points for 85 sentences read in jp, it, es, or en" do
        score = Calc.sent_count(85, "jp")

        score.should eq(5)
      end

      it "should return 5 points for 115 sentences in eo" do
        score = Calc.sent_count(115, "eo")

        score.should eq(5)
      end

      it "should return 5 points for 90 sentences in ko" do
        score = Calc.sent_count(90, "ko")

        score.should eq(5)
      end

      it "should return 5 points for 125 sentences in zh" do
        score = Calc.sent_count(125, "zh")

        score.should eq(5)
      end

      it "should return 5 points for 65 sentences in de" do
        score = Calc.sent_count( 65,"de")

        score.should eq(5)
      end

      it "should return 5 points for 80 sentences in fr" do
        score = Calc.sent_count(80,"fr")

        score.should eq(5)
      end

      it "should return 5 points for 120 sentences in ru" do
        score = Calc.sent_count(120, "ru")

        score.should eq(5)
      end

      it "should return 5 points for 150 sentences in nl" do
        score = Calc.sent_count(150, "nl")

        score.should eq(5)
      end

      it "should return 5 points for 155 sentences in af" do
        score = Calc.sent_count(155, "af")

        score.should eq(5)
      end

      it "should return 5 points for 40 sentences in ar" do
        score = Calc.sent_count(40, "ar")

        score.should eq(5)
      end

      it "should return 5 points for 165 sentences in all other languages" do
        score = Calc.sent_count(165, "alien")

        score.should eq(5)
      end
    end

    describe "Repeats" do
      it "should return 25 points for 50 book pages read twice" do
        score = Calc.repeat(50,1)

        score.should eq(25)
      end

      it "should return 12.5 for 50 book pages read three times" do
        score = Calc.repeat(50,2)

        score.should eq(12.5)
      end

      it "should return 6.25 for 50 book pages read four times" do
        score = Calc.repeat(50, 3)

        score.should eq(6.25)
      end

      it "should return 3.125 for 50 book pages read five times" do
        score = Calc.repeat(50,4)

        score.should eq(3.125)
      end
    end

    describe "User medium information" do
      #fill in when users and rounds are properly being created via factory girl
    end
  end
end
