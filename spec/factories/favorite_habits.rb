FactoryBot.define do
  factory :favorite_habit do
    association :user
    association :habit
  end
end
