require 'spec_helper'

describe "Update Pages" do

  before do
    sign_in
    visit root_path
  end

  subject { page }

  describe "a non-registered user attempting to submit an update" do

    it "should not allow an unregistered user to update" do
      page.should have_selector("h2", "You must be registered for the current round in order to submit an update.")
    end
  end

  describe "a registered user submitting an update" do
    before do
      user = User.find_by_uid(123545)
      user_round = user.rounds.create!(round_id: ApplicationHelper::curr_round, lang1: 'jp',
                                                          lang2: 'en', lang3:'zh', tier: 'Bronze', book:  10, manga: 10,
                                                          fgame: 10, game: 10, net: 10, news: 10, lyric: 10,
                                                          subs: 10, nico: 10, sent:10, pcount: 1010)
      visit root_path
  end

    it "should update successfully" do
      fill_in('Amount Read', :with => '10')
      select "book", :from => "Medium Read"
      select "Japanese", :from => "Language"
      click_button "Submit Update"
      save_and_open_page
      page.should have_selector('alert-success', :text => "Update successfully submitted")
    end
  end

  describe "a registered user attempting to submit an update before a round" do
    it "should not allow the user to update" do
      click_link("Update")
      page.should have_selector("h2", "You're either too fast, or too slow")
    end
  end

  describe "a registered user attempting to submit an update after a round" do
    it "should not allow the user to update" do
      click_link("Update")
      page.should have_selector("h2", "You're either too fast, or too slow")
    end
  end
end
