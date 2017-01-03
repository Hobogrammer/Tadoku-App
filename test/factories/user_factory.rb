FactoryGirl.define do
  factory :user do
    provider "twitter"
    sequence("uid") { |n| "100#{n}" }
    timezone "Pacific Time (US & Canada)"
    sequence("profile_img") { |n| "http://server.com/image_#{n}.png" }
    sequence("name") { |n| "Tadoku_User#{n}" }

    factory :admin do
      admin true
    end
  end
end
