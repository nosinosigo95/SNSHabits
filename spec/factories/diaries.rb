FactoryBot.define do
  factory :diary do
    description { "今日の日記" }
    doing_time { "00:01" }
    private { 1 }
  end
end
