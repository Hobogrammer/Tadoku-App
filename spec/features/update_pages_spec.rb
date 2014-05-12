require 'spec_helper'

describe "Update Pages" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in :user
  end

  subject { page }

  describe "a registered user submitting an update" do

  end

  describe "a non-registerd user attempting to submit an update" do

  end

  describe "a user attempting to submit an update before or after a round" do

  end
end
