FactoryBot.define do
  factory :diary do
    sequence(:description) { |n| "今日の日記#{n}" }
    doing_time { "00:01" }
    action_date { "2024-06-18" }
    private { false }
    association :user
    association :habit
  end
end
