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
end
