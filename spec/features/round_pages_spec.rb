require 'spec_helper'

describe "RoundPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before do
      sign_in user
  end

  describe "Ranking page" do
    it "should contain all users" do

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


