require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @user = User.new(provider: "twitter", uid: "691563", name: "Twitter User",
                           timezone: "Pacific Time (US & Canada)", 
                           profile_img: "https://example.com/img.png") }

  def test_respond_provider
    assert_respond_to @user, :provider
  end

  def test_respond_uid
    assert_respond_to @user, :uid
  end

  def test_respond_name
    assert_respond_to @user, :name
  end

  def test_respond_timezone
    assert_respond_to @user, :timezone
  end

  def test_respond_profile_img
    assert_respond_to @user, :profile_img
  end

  def test_respond_admin
    assert_respond_to @user, :admin
  end
end
