FactoryBot.define do
  TEXT_REP_NUM = 10
  factory :habit do
    name { "goodhabit" }
    # association :user
    factory :dup_name_habit do
    end
    factory :dup_creating_id_habit do
      name { "habit" }
    end
  end
end
