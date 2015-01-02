require 'spec_helper'

describe Round do

  let(:user) { FactoryGirl.create(:user) }
  before { @round = user.rounds.build(round_id: "201202") }

  subject { @round }

  it { should respond_to(:user_id) }
  it { should respond_to(:round_id) }
  it { should respond_to(:book) }
  it { should respond_to(:manga) }
  it { should respond_to(:net) }
  it { should respond_to(:fgame) }
  it { should respond_to(:game) }
  it { should respond_to(:lyric) }
  it { should respond_to(:subs) }
  it { should respond_to(:news) }
  it { should respond_to(:sent) }
  it { should respond_to(:nico) }
  it { should respond_to(:pcount) }
  it { should respond_to(:goal) }
  it { should respond_to(:gmet) }
  it { should respond_to(:lang1) }
  it { should respond_to(:lang2) }
  it { should respond_to(:lang3) }
  it { should respond_to(:tier) }

  its(:user) { should == user }

  describe "getting user rank" do

  end

  describe "getting ranking by language" do

  end

  describe "getting a sorted tier list"  do

  end

  describe "getting the languages list" do
  
  end

  describe "getting user list" do

  end

  describe "getting user list by teir" do

  end

  describe "building a user round" do

  end

  describe "getting a list of previous rounds" do

  end
end
