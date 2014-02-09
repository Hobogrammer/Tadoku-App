require 'spec_helper'

describe ApplicationHelper do
  describe "curr_round" do

    it "should return 201301 for December 2012" do
      before_round1 = Time.utc(2012, 12, 1,11)
      Timecop.freeze(before_round1)
      ApplicationHelper::curr_round().should =~ /201301/
      Timecop.return
    end

    it "should return 201201 for January 2012" do
      round1 = Time.local(2012, 1, 1)
      Timecop.freeze(round1)
      ApplicationHelper::curr_round().should =~ /201201/
      Timecop.return
    end

    it "should return 201205 for March 2012" do
      round1_5 = Time.utc(2012, 3, 1,11)
      Timecop.freeze(round1_5)
      ApplicationHelper::curr_round().should =~ /201203/
      Timecop.return
    end

    it "should return 201206 for May 2012" do
      round2 = Time.utc(2012,5,1,11)
      Timecop.freeze(round2)
      ApplicationHelper::curr_round().should =~ /201206/
      Timecop.return
    end

    it "should return 201208 for August 2012" do
      round2_5 = Time.utc(2012,8,1,11)
      Timecop.freeze(round2_5)
      ApplicationHelper::curr_round().should =~ /201208/
      Timecop.return
    end

    it "should return 201210 for October 2012" do
      round3 = Time.utc(2012,10,1,11)
      Timecop.freeze(round3)
      ApplicationHelper::curr_round().should =~ /201210/
      Timecop.return
    end
  end
end
