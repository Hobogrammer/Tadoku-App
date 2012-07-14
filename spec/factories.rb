FactoryGirl.define do 
	factory :user do
		provider "twitter"
		uid "123456"
		name "JowJebus"

		factory :admin do
			admin true
		end
	end
end