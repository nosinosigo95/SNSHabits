FactoryBot.define do
  factory :effect do
    sequence(:effect_item) { |n| "effect#{n}" }
  end
end
