require 'spec_helper'

OmniAuth.config.add_mock(:twitter, {:uid => '123456', :info => { :nickname => 'JowJebus' }})

describe "RoundPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) } 

	before do
  		request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
  		sign_in user
	end


  describe "Main ranking" do
  		before { visit ranking_path }

  		it { should have_selector('h1', text:'Tadoku Ranking page') }
  		it { should have_selector('title', text: 'Tadoku Ranking') }

  		it "should have all users in the ranking" do
  			Rounds.find_by_round_id(current_round).each do |round|
  				page_should have_selector('li', text: User.find_by_id(round.user_id))
  			end
  		end
  	end


  describe "registering for contest" do
  		
  		before { visit root_path }

  		it "should increment the rounds count" do
  			expect do
  				click_button 'Register for the next round'

  			end.to change(user.rounds, :count).by(1)
  		end
  	end
end


