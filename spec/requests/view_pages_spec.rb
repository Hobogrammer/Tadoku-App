require 'spec_helper'

describe "ViewPages" do

	subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'Welcome to the Tadoku App!') }

    describe "after signin" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
      end

      it "should greet the user" do
        page.should have_selector('h1', text: user.name)
      end

      it "should have a register for round button" do

        page.should have_selector('a', class:'btn btn-large btn-primary')
      end
    end
  end

  describe "About page" do
  		before { visit about_path }

  		it { should have_selector('h3', text: 'About Tadoku') }
  	end

  	describe "Manual page" do
  		before { visit manual_path }

  		it { should have_selector('h3', text: 'Tadoku Manual') }
  	end
end
