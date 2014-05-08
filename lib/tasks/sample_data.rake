namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Test user",
                              provider: "twitter",
                              uid: "12345",
                              time_zone: "Central US")
    99.times do |n|
      name = Faker::Internet.user_name
      provider = "twitter"
      uid = Faker::number(6)
      time_zone = Faker::Address.time_zone
      User.create!(name: name,
                                provider: provider,
                                uid: uid,
                                time_zone: time_zone)
    end
  end
end
