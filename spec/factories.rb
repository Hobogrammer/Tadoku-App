FactoryGirl.define do
  factory :user do
    sequence("name") { |n| "Person #{n}" }
    sequence("uid") { |n| "100#{n}"}
    provider "twitter"
    time_zone "Pacific Time (US & Canada)"
    avatar "www.immakingthisup.com/hi.jpg"

      factory :admin do
        admin true
      end
    end

  factory :update do
    user
    medium "book"
    sequence("newread") { |n| "#{n}"}
    lang "jp"
  end
end
