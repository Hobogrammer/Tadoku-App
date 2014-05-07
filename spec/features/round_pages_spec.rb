require 'spec_helper'

describe "RoundPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe "Ranking page" do
    it "should contain all users currently registered in the current round" do
      Round.where(round_id: ApplicationHelper::curr_round).each do |round|
        expect( page ).to have_selector('li', text: round.user.name)
      end
    end

    it "should link to users record for that round " do

    end

    it "should have the users page count" do

    end
  end

  describe "Past ranking" do
    it "should have the proper round link to the user profile" do

    end
  end
end
