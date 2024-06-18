FactoryBot.define do
  factory :diary do
    description { "今日の日記" }
    doing_time { "00:01" }
    action_date { "2024-06-18" }
    association :user
    association :habit
  end
end
