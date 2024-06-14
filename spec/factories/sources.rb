FactoryBot.define do
  factory :source do
    url { "MyString" }
    association :habit
  end
end
