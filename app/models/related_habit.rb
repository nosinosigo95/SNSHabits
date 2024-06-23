class RelatedHabit < ApplicationRecord
  belongs_to :old_habit, class_name: 'Habit'
  belongs_to :now_habit, class_name: 'Habit'
end
