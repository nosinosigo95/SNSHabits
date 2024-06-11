class AddHabitIdToEffect < ActiveRecord::Migration[6.1]
  def change
    add_reference :effects, :habit, foreign_key: true
  end
end
