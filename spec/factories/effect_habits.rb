FactoryBot.define do
  factory :effect_habit do
    association :effect
    association :habit
  end
end
