require 'spec_helper'

OmniAuth.config.test_mode = true

OmniAuth.config.add_mock(:twitter, { :uid => '123456', :info => { :nickname => 'someguy' }})

describe "Authentication" do

	subject { page }

	describe "not signed in" do
		before { visit root_path }

		it { should have_link('Sign in', href: signin_path) }
	end

	describe " after signin via twitter" do
		before { visit signin_path }

		it { should have_link('Sign out', href: signout_path) }
	end
end


