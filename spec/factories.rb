FactoryGirl.define do
  factory :user do
    sequence("id") { |n| "100#{n}"}
    sequence("name") { |n| "Person #{n}" }
    sequence("uid") { |n| "100#{n}"}
    provider "twitter"
    time_zone "Pacific Time (US & Canada)"

      factory :admin do
        admin true
      end
    end

    factory :round do
      round_id ApplicationHelper::curr_round
      sequence("user_id") { |n| "100#{n}"}
      sequence("book") { |n| }
      sequence("manga") { |n| "#{n}" }
      sequence("fgame") { |n| "#{n}" }
      sequence("game") { |n| "#{n}" }
      sequence("net") { |n| "#{n}" }
      sequence("news") { |n| "#{n}" }
      sequence("lyric") { |n| "#{n}" }
      sequence("subs") { |n| "#{n}" }
      sequence("nico") { |n| "#{n}" }
      sequence("sent") { |n| "#{n}" }
      sequence("pcount") { |n| "10#{n}"}
      goal 0
      lang1 "jp"
      lang2 "en"
      lang3 "zh"
      tier "Bronze"
  end

  factory :update do
    sequence("user_id") { |n| "100#{n}"}
    medium "book"
    sequence("newread") { |n| "#{n}"}
    lang "jp"
  end
end
