module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:twitter] = {
      'provider' => 'twitter',
      'uid' => '123545',
      'info' => {
        'nickname' => 'Person 1',
        'image' => 'www.immakingthisup.com/hi.jpg'
      },
      'extra' => {
        'raw_info' => {
          'time_zone' => 'Europe/Paris'
        }
      }
    }
  end
end
