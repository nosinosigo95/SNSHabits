module DiariesHelper
  def get_favorite_habit
    favorite_habit = {}
    current_user.favorites.each do |habit|
      favorite_habit[habit.name] = habit.id
    end
    favorite_habit
  end

  def get_continuation_habit
    continuation_habits = {}
    current_user.continuations.each do |continuation|
      if continuation.now
        habit = continuation.habit
        continuation_habits[habit.name] = habit.id
      end
    end
    continuation_habits
  end
  def sum_doing_time(diaries)
    hours = 0
    minutes = 0
    diaries.each do |diary|
      doing_time = /\A\d{1,2}:\d{1,2}\z/.match(diary.doing_time)
      hours = hours + doing_time[0].to_i
      times = times + doing_time[1].to_i
    end
    hours + minutes / 60
  end
end
