require 'spec_helper'


OmniAuth.config.add_mock(:twitter, {:uid => '123456', :info => { :nickname => 'JowJebus' }})

describe "User Pages" do
  let(:user) { FactoryGirl.create(:user) }
	    
 	before do
 		# request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]  
		sign_in user
	end
	    
  subject { user }

  describe "index" do

  		before do
  		 sign_in user
  		 visit users_path
  		end

  		it { should have_selector('title', text: 'Tadoku Ranking') }
  		it { should have_selector('h1', text: 'Tadoku Ranking') }

  		it "should list all users in the ranking" do
  			User.all.each do |user|
  				page.should have_selector('li', text: user.name)
  			end
  		end
  	end

  describe "making an update" do

		before do 
			visit root_path
			click_link 'Update'
      
			fill_in "language", with: "jp"
			fill_in "medium", with: "book"
			fill_in "pages", with: "120"
		end

		it "should add update" do
			expect { click_button "Submit" }.to change(user.rounds, :count).by(1)
		end
	end
end
