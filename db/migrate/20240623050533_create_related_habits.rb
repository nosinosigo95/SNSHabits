class CreateRelatedHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :related_habits do |t|
      t.timestamps
      t.bigint :old_habit_id
      t.bigint :now_habit_id
    end
    add_foreign_key :related_habits, :habits, column: :old_habit_id
    add_foreign_key :related_habits, :habits, column: :now_habit_id
  end
end
