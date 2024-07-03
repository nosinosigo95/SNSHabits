FactoryBot.define do
  factory :comment do
    comment { "MyText" }
    association :user
    association :habit
  end
end
