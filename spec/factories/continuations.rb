FactoryBot.define do
  factory :continuation do
    now { true }
    association :user
    association :habit
  end
end
