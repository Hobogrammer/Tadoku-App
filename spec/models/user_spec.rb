require 'spec_helper'

describe User do

  before { @user = User.new(provider: "twitter", uid: "691563", name: "True Neighbor", time_zone: "Central US") }

  subject { @user }

  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:name) }
  it { should respond_to(:admin) }
  it { should respond_to(:time_zone) }
  it { should respond_to(:avatar) }

  it { should be_valid }
  it { should_not be_admin }

  describe "when admin attribute is set to true" do
      before { @user.toggle!(:admin) }

      it { should be_admin }
    end

  describe "when there is no provider present" do
    before { @user.provider = nil }

    it { should_not be_valid }
  end

  describe "when there is no uid present" do
    before { @user.uid = nil }

    it { should_not be_valid }
  end

  describe "when there is no name present" do
      before { @user.name = nil }

      it { should_not be_valid }
    end

    describe "when there is no time zone present" do
      before { @user.time_zone = nil }

      it { should_not be_valid }
    end
end
