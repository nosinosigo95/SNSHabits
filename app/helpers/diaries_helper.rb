module DiariesHelper
  def get_favorite_habit(favorites)
    favorite_habit = {}
    favorites.each do |favorite|
      habit = favorite.habit
      favorite_habit[habit.name] = habit.id
    end
    favorite_habit
  end

  def get_continuation_habit(continuations)
    continuation_habits = {}
    continuations.each do |continuation|
      if continuation.now
        habit = continuation.habit
        continuation_habits[habit.name] = habit.id
      end
    end
    continuation_habits
  end

  def sort_diaris(diaries)
    diaries.sort do |a, b|
      b.action_date <=> a.action_date
    end
  end

  # [0日前, 1日前, 2日前, 3日前, 4日前, 5日前, 6日前]
  def doing_times_before_days(diaries)
    day_week = 7
    doing_times = [0] * day_week
    before_days = [
      0.day.ago.strftime('%Y-%m-%d'),
      1.day.ago.strftime('%Y-%m-%d'),
      2.day.ago.strftime('%Y-%m-%d'),
      3.day.ago.strftime('%Y-%m-%d'),
      4.day.ago.strftime('%Y-%m-%d'),
      5.day.ago.strftime('%Y-%m-%d'),
      6.day.ago.strftime('%Y-%m-%d'),
    ]

    before_days_i = 0
    diaries.each do |diary|
      while before_days_i < before_days.count
        if diary.action_date.strftime('%Y-%m-%d') == before_days[before_days_i]
          break
        end
        before_days_i += 1
      end
      break if before_days_i >= before_days.count

      doing_times[before_days_i] =
        doing_times[before_days_i].to_f + change_doing_time_to_hour(diary.doing_time)
    end
    doing_times
  end

  # doing_time: "時：分"
  def change_doing_time_to_hour(doing_time)
    doing_time_match = /\A(\d{1,2}):(\d{1,2})\z/.match(doing_time)
    hours = doing_time_match[0].to_i
    minutes =  doing_time_match[1].to_i
    hours.to_f + minutes.to_f / 60.to_f
  end
end
