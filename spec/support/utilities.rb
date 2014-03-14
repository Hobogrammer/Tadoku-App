include ApplicationHelper

def sign_in(user)
	OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => '123545',
      :name => "JowJebus",
      :time_zone => "Pacific Time (US & Canada)"
    })
	visit signin_path
end
