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
end
