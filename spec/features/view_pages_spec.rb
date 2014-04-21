require 'spec_helper'

describe "ViewPages" do

	subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'Welcome to the Tadoku App!') }

    describe "after signin as an unregisterd user" do
      let(:unreg_user) { FactoryGirl.create(:unreg_user) }
      before do
        puts unreg_user.name
        sign_in user
      end

      it "should greet the user" do
        page.should have_selector('h1', text: user.name)
      end

      it "should have a register for round button" do

        page.should have_link('Register for the next round')
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
