require 'spec_helper'

describe "ViewPages" do
	
	subject { page }  

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'Welcome to the Tadoku App!') }
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
