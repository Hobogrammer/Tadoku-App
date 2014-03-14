require 'spec_helper'


describe "User Pages" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  subject { page }

  describe "user profile" do

    before do
      visit user_path(user)
    end

    it { should have_content user.name; save_and_open_page }
  end
end
