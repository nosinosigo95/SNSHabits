class RelatedHabit < ApplicationRecord
  belongs_to :old_habit, class_name: 'Habit', foreign_key: "old_habit_id"
  belongs_to :now_habit, class_name: 'Habit', foreign_key: "now_habit_id"
end
