# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_num = 16
start_id = 1
user_id_sft = 3
increase_sft = 1
effect_num = 10
diary_num = 5

# users
User.create!(
  name: "guest",
  email: "guest@example.com",
  password: "123456",
  introduction: "よろしくお願いします。"
)

user_num.times do |i|
  User.create!(
    name: "ユーザー#{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "123456",
    introduction: "よろしくお願いします。"
  )
end

# follows
User.all.each do |user|
  Follow.create!(
    follower_id: user.id,
    followed_id: (user.id + user_id_sft) % user_num + start_id
  )
end

# effect
effect_num.times do |i|
  Effect.create(effect_item: "効果#{i + 1}")
end

# habits
User.all.each do |user|
  user.habits.create!(
    name: "習慣#{user.id}",
    summary: "習慣#{user.id}は、〇〇をします。",
    scheme: "習慣#{user.id}は、〇〇をします。\n手順は以下のように行います。\n 手順1: \n手順2:",
    period_for_effect: "4週間",
    working_time: "01:00",
    challenge: "true",
    commit: "false"
  )
end
User.all.each do |user|
  user.habits.create!(
    name: "習慣#{user.id + User.count}",
    summary: "習慣#{user.id + User.count}は、〇〇をします。",
    scheme: "習慣#{user.id + User.count}は、〇〇をします。\n手順は以下のように行います。\n 手順1: \n手順2:",
    period_for_effect: "2ヶ月",
    working_time: "02:00",
    challenge: "false",
    commit: "true"
  )
end

# effect_habits
Habit.all.each do |habit|
  rand(1..5).times.each do |effect_id|
    EffectHabit.create!(
      habit_id: habit.id,
      effect_id: (effect_id + increase_sft) % Effect.count + start_id
    )
  end
end
habit_count = Habit.count
for i in (1..habit_count - 1)
  for j in (1..habit_count - 1)
    if i > j
      RelatedHabit.create!(old_habit_id: i, now_habit_id: j)
    end
  end
end

# sources
Habit.all.each do |habit|
  habit.sources.create!(url: "https://www.youtube.com/")
  habit.sources.create!(url: "https://www.google.co.jp/")
end

User.all.each do |user|
  habit_id = rand(1..Habit.count)
  # continuations
  user.continuations.create!(
    habit_id: habit_id,
    now: true
  )

  # diaries
  diary_num.times.each do |i|
    user.diaries.create!(
      description: "今日の進捗は〇〇でした。\n明日は、〇〇します。",
      action_date: "2024/6/23",
      doing_time: "01:00",
      private: i % 2 == 1,
      habit_id: habit_id
    )
    user.diaries.create!(
      description: "今日の進捗は〇〇でした。",
      action_date: "2024/6/22",
      doing_time: "00:01",
      private: i % 2 == 1,
      habit_id: habit_id
    )
  end

  # favorite_habits
  user.favorite_habits.create!(habit_id: habit_id)
  user.favorite_habits.create!(
    habit_id: (habit_id + increase_sft) % Habit.count + start_id
  )
end
