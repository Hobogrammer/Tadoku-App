require 'spec_helper'


describe "User Pages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:round) { FactoryGirl.create(:round) }

  before do
    visit user_path(round,user)
  end

  subject { page }

  describe "user profile" do

    it { should have_content "Stats of Wrath" }
    it { should have_content user.name }
    it { should have_css('img') }

    it "should have a link to user's twitter account" do
      page.should have_link( user.name , href: "http://twitter.com/#{user.name}")
    end

    describe "medium chart" do
      it "should show data" do

        page.should have_css( "tr:nth-child(1) td:nth-child(2)", :text => "#{round.book.to_f}")
      end
    end
  end
end
