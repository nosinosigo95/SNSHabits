FactoryBot.define do
  factory :habit do
    name { "習慣名" }
    scheme { "工夫" }
    association :user
  end
end
