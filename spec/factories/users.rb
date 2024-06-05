FactoryBot.define do
  factory :user do
    name {"guest"}
    email {"sample@example.com"}
    password {"123456"}
    after(:build) do |user|
       user.icon.attach(io: File.open('spec/fixtures/image/person-circle.svg'), filename: 'person-circle.svg', content_type: 'image/svg')
     end
  end
end
