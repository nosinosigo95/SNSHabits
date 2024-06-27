module HabitsHelper
  def get_url_max
    3
  end

  def get_circumstance(habit)
    if habit.nil?
      nil
    elsif habit.commit?
      "結果済み"
    elsif habit.challenge?
      "挑戦中"
    end
  end

  def is_have_favorite_habit(habit)
    current_user.favorite_habits.where(habit_id: habit.id).present?
  end

  def is_continued(habit)
    current_user.continuations.where(habit_id: habit.id).present?
  end
end
