class RemoveHabitIdToEffect < ActiveRecord::Migration[6.1]
  def change
    remove_column :effects, :habit_id, :bigint
  end
end
