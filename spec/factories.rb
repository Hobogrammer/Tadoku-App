FactoryGirl.define do
  factory :user do
    id 5
    provider "twitter"
    uid "123456"
    name "JowJebus"
    time_zone "Pacific Time (US & Canada)"

      factory :admin do
        admin true
      end
    end

    factory :round do
      id 16
      round_id ApplicationHelper::curr_round
      user_id 5
      book 10.0
      manga 50.0
      fgame 60.0
      game 20.0
      net 10.0
      news 10.0
      lyric 10.0
      subs 100.0
      nico 100.0
      sent 170.0
      pcount 100.0
      goal 0
      lang1 "jp"
      lang2 "en"
      lang3 "zh"
      tier "Bronze"
  end

  factory :update do
    user_id 5
    round_id 16
    lang "jp"
    newread 10.0
    medium "book"
  end
end
