FactoryBot.define do
  TEXT_REP_NUM = 10
  factory :good_habit do
    name { "good_habit" }
    creating_user_id { 1 }
    # association :user

    factory :dup_name_good_habit do
      creating_user_id { 2 }
    end
    factory :dup_creating_id_good_habit do
      name { "habit" }
    end
  end
end
