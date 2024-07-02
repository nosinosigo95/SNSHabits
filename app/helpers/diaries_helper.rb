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
    recently_doing_times_hours = [0.0] * day_week
    recently_doing_times_minutes = [0.0] * day_week
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

      recently_doing_times_hours[before_days_i] += choose_hour_of_doing_time(diary.doing_time)
      recently_doing_times_minutes[before_days_i] += choose_minute_of_doing_time(diary.doing_time)
    end
    sum_doing_times_per_day(recently_doing_times_hours, recently_doing_times_minutes)
  end

  def sum_doing_times_per_day(hours, minutes)
    day_week = 7
    doing_times = [0.0] * day_week
    i = 0
    hours.zip(minutes) do |hour, minute|
      doing_times[i] += (hour + minute / 60.to_f)
      i += 1
    end
    doing_times
  end

  # doing_time: "時：分"
  def choose_hour_of_doing_time(doing_time)
    doing_time_match = /\A(\d{1,2}):\d{1,2}\z/.match(doing_time)
    doing_time_match[1].to_f
  end

  def choose_minute_of_doing_time(doing_time)
    doing_time_match = /\A\d{1,2}:(\d{1,2})\z/.match(doing_time)
    doing_time_match[1].to_f
  end

  def initialize_doing_time(diary)
    diary.doing_time = "00:00" if diary.doing_time.nil?
  end
end
