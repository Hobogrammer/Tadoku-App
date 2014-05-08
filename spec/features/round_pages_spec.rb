require 'spec_helper'

describe "RoundPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before(:all) { 30.times { FactoryGirl.create(:user) } }
  after(:all) { User.delete_all }

  describe "Ranking page" do

    before do
      visit ranking_path
    end

    it "should contain all users currently registered in the current round" do
      Round.where(round_id: ApplicationHelper::curr_round).each do |round|
        expect( page ).to have_selector('li', text: round.user.name)
      end
      save_and_open_page
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
