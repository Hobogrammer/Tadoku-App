require 'spec_helper'

OmniAuth.config.add_mock(:twitter, {:uid => '123456', :info => { :nickname => 'JowJebus' }})

describe RoundsController do
	let(:user) { FactoryGirl.create(:user) }

	before do
  		request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
  		sign_in user
	end

  describe "registering for contest" do
  		
  		before { visit root_path }

  		it "should increment the rounds count" do
  			expect do
  				click_button 'Register for the next round'

  				puts user.name

  			end.to change(user.rounds, :count).by(1)
  		end
  	end
end