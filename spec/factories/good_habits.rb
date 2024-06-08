FactoryBot.define do
  TEXT_REP_NUM = 10
  factory :good_habit do
    name { "good_habit" }
    effect { "text" * TEXT_REP_NUM }
    creating_user_id { 1 }
    # association :user
    factory :dup_id_and_name_good_habit do
      effect { "dup" * TEXT_REP_NUM }
    end
  end
end
