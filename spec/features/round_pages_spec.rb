require 'spec_helper'

describe "RoundPages" do
  subject { page }

  before(:all) {
    30.times  do |n|
      user = FactoryGirl.create(:user)
      round = user.rounds.new(round_id: ApplicationHelper::curr_round, lang1: 'jp',
                                                        lang2: 'en', lang3:'zh', tier: 'Bronze', book:  "#{n}", manga: "#{n}",
                                                        fgame: "#{n}", game: "#{n}", net: "#{n}", news: "#{n}", lyric:"#{n}",
                                                        subs: "#{n}", nico: "#{n}", sent:"#{n}", pcount: "10#{n}")
    end
  }

  after(:all) {
    User.delete_all
    Round.delete_all
  }

  describe "Ranking page" do

    before do
      visit round_path(ApplicationHelper.curr_round)
    end

    it "should contain all users currently registered in the current round" do
      round_count = Round.where(round_id: ApplicationHelper::curr_round).count
      Round.where(round_id: ApplicationHelper::curr_round).each do |round|
        expect( page ).to have_selector('td', text: round.user.name)
      end
    end

    it "should link to users record for that round " do
      Round.where(round_id: ApplicationHelper::curr_round).each do |round|
        expect( page ).to have_link( "#{round.user.name}")
      end
    end

    it "should have the users page count" do
      Round.where(round_id: ApplicationHelper::curr_round).each do |round|
        expect( page ).to have_selector('td', text: round.pcount)
      end
    end
  end

  describe "Past ranking" do
    it "should have the proper round link to the user profile" do
      #need to be able to generate rounds with not current round id
    end
  end

describe "Registering for a round", :js => true do

    before do
      sign_in
      visit root_path
    end

    it "should successfully register a signed in user" do
      find('.btn').click
      select "#{ApplicationHelper::curr_round}", :from => "Round"
      select "Japanese", :from => "Lang1"
      select "Chinese", :from => "Lang2"
      select  "Korean", :from => "Lang3"
      select  "32", :from => "Goal"
      click_button "Register"

      page.should have_content "You have successfully registered for the Tadoku contest"
    end
  end
end
