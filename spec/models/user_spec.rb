# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  admin      :boolean         default(FALSE)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do

  before { @user = User.new(provider: "twitter", uid: "691563", name: "True Neighbor") }

  subject { @user }

  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:name) }
  it { should respond_to(:admin) }

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
end
