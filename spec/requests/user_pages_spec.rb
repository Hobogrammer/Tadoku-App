require 'spec_helper'

OmniAuth.config.add_mock(:twitter, {:uid => '123456', :info => { :nickname => 'JowJebus' }})

describe "User Pages" do
  let(:user) { FactoryGirl.create(:user) }
	    
 	before do
 		request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
		sign_in user
	end
	    
  subject { user }

  describe "making an update" do

		before do 
			visit root_path
			click_button 'update'
      
			fill_in "language", with: "jp"
			fill_in "medium", with: "book"
			fill_in "pages", with: "120"
			click_button "Submit"
		end

		it " update should appear on user#s update feed" do

			before {visit update_path(user) }	

			page.should have_content('120')
		end
	end
end
