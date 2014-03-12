require 'spec_helper'

VCR.use_cassette(twitter) do
  describe Bot do
    it "should properly process a user tweet" do
      test = Bot.main
      test.should_equal true
    end
  end
end
