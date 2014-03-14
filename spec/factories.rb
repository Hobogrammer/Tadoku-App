FactoryGirl.define do
	factory :user do
		provider "twitter"
		uid "123456"
		name "JowJebus"
    time_zone "Pacific Time (US & Canada)"

		factory :admin do
			admin true
		end
	end
end
