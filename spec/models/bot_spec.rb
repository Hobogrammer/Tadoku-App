require 'spec_helper'

describe Bot do
  it "should properly process a user tweet", :vcr do
    test = Bot.main
    test.should_equal true
  end
end
