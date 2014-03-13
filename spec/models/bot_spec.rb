require 'spec_helper'

describe Bot do
  it "should properly process a user tweet", :vcr do
    VCR.use_cassette('should_properly_process_a_user_tweet.yml', :match_requests_on => [:method]) do
      test = Bot.main
      test.should equal(true)
    end
  end
end
