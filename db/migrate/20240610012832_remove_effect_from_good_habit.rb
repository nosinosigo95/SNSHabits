class RemoveEffectFromGoodHabit < ActiveRecord::Migration[6.1]
  def change
    remove_column :good_habits, :effect, :text
  end
end
