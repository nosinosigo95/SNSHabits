FactoryBot.define do
  TEXT_REP_NUM = 10
  factory :habit do
    name { "goodhabit" }
    creating_user_id { 1 }
    # association :user

    factory :dup_name_habit do
      creating_user_id { 2 }
    end
    factory :dup_creating_id_habit do
      name { "habit" }
    end
  end
end
