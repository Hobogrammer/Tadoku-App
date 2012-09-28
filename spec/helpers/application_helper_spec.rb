require 'spec_helper'

describe ApplicationHelper do

	describe "curr_round" do

		it "should return 201203 for August 2012" do
			Timecop.freeze(Date.today)
			curr_round().should =~ /201203/
			Timecop.return
		end

		it "should return 201301 for December 2012" do
			endofdays = Time.local(2012, 12, 1)
			Timecop.freeze(endofdays)
			curr_round().should =~ /201301/
			Timecop.return
		end

		it "should return 201201 for January 2012" do 
			early2012 = Time.local(2012, 1, 1)
			Timecop.freeze(early2012)
			curr_round().should =~ /201201/
			Timecop.return
		end

		it "should return 201202 for March 2012" do
			secquar2012 = Time.local(2012, 3, 1)
			Timecop.freeze(secquar2012)
			curr_round().should =~ /201202/
			Timecop.return 
		end
	end
end