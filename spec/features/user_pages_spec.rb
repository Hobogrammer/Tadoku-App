require 'spec_helper'


describe "User Pages" do

  let!(:user) { FactoryGirl.create(:user, name: "Joe_user") }

   before do
      round = user.rounds.create(round_id: ApplicationHelper::curr_round, lang1: 'jp',
                                                        lang2: 'en', lang3:'zh', tier: 'Bronze', book:  10 , manga: 10,
                                                        fgame: 10, game: 10, net: 10, news: 10, lyric: 10,
                                                        subs: 10, nico: 10, sent: 10, pcount: "1010")
      visit user_path(user)
    end

  subject { page }

  describe "user profile" do
    it {should have_content "Stats of Wrath" }
    it { should have_content user.name }
    it { should have_css('img') }

    it "should have a link to user's twitter account" do
      page.should have_link( user.name , href: "http://twitter.com/#{user.name}")
    end

    describe "medium chart" do
      it "should show data" do

        page.should have_css( "tr:nth-child(1) td:nth-child(2)", :text => "10")
      end
    end
  end
end
