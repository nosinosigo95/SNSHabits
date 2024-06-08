FactoryBot.define do
  TEXT_REP_NUM = 10
  factory :good_habit do
    name { "good_habit" }
    effect { "text" * TEXT_REP_NUM }
    creating_user_id { 1 }
    # association :user
    factory :dup_name_good_habit do
      creating_user_id { 2 }
      effect { "dup" * TEXT_REP_NUM }
    end
    factory :dup_creating_id_good_habit do
      name { "habit" }
      effect { "habit_habit" * TEXT_REP_NUM }
    end
  end
end
