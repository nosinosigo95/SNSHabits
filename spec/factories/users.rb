FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "sample#{n}" }
    sequence(:email) { |n| "sample#{n}@example.com" }
    password { "123456" }
    after(:build) do |user|
      user.icon.attach({
        io: File.open('spec/fixtures/image/person-circle.svg'),
        filename: 'person-circle.svg',
        content_type: 'image/svg',
      })
    end
  end
  factory :followed_user do
    name { "example" }
    email { "example@example.com" }
    password { "123456" }
    after(:build) do |user|
      user.icon.attach({
        io: File.open('spec/fixtures/image/person-circle.svg'),
        filename: 'person-circle.svg',
        content_type: 'image/svg',
      })
    end
  end
end
