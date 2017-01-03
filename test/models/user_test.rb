require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @user = FactoryGirl.create(:user) }

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

  def test_create_from_auth_hash
    user = User.find_or_create_from_auth_hash(create_mock_auth)
    assert_equal(user.uid, create_mock_auth[:uid])
    assert_equal(user.provider, create_mock_auth[:provider])
    assert_equal(user.name, create_mock_auth[:info][:nickname])
    assert_equal(user.profile_img, create_mock_auth[:info][:image])
    assert_equal(user.timezone, create_mock_auth[:extra][:raw_info][:time_zone])
  end

  def test_find_from_auth_hash
    user = User.find_or_create_from_auth_hash(mock_auth) 
    assert_equal(user.uid, @user.uid)
  end

  def test_find_from_auth_hash_updates_new_data
    user = User.find_or_create_from_auth_hash(mock_auth)
    assert(user.profile_img, mock_auth[:info][:image])
  end

  def mock_auth
    {
      :provider => "twitter",
      :uid => @user.uid,
      :info => {
        :nickname => @user.name,
        :image => "https://example.com/new_img.png"
      },
      :extra => {
        :raw_info => {
          :time_zone => "Pacific Time (US & Canada)"
        }
      }
    }
  end

  def create_mock_auth
    {
      :provider => "twitter",
      :uid => "691563",
      :info => {
        :nickname => "Twitter User",
        :image => "https://example.com/img.png"
      },
      :extra => {
        :raw_info => {
          :time_zone => "Eastern Time (US & Canada)"
        }
      }
    }
  end
end
