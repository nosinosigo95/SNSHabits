class ChangeGoodHabitsToHabits < ActiveRecord::Migration[6.1]
  def change
    rename_table :good_habits, :habits
  end
end
