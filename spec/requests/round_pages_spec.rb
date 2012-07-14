require 'spec_helper'

describe "RoundPages" do
  subject { page }

  describe "Main ranking" do
  		before { visit ranking_path }

  		it { should have_selector('h1', text:'Tadoku Ranking page') }
  	end
end
