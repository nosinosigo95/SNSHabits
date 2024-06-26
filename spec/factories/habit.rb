FactoryBot.define do
  factory :habit do
    sequence(:name) { |n| "習慣名#{n}" }
    sequence(:scheme) { |n| "工夫#{n}" }
    working_time { "01:00" }
    period_for_effect { "1ヶ月" }
    recently_viewed_time { Time.zone.now }
    sequence(:challenge) { |n| (n%2 == 0) }
    sequence(:commit) { |n| (n%2 == 1) }
    sequence(:summary) { |n| "概要#{n}" }
    association :user
  end
end
