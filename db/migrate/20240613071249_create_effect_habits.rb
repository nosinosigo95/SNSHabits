class CreateEffectHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :effect_habits do |t|
      t.references :effect, index: true, foreign_key: true
      t.references :habit, index: true, foreign_key: true

      t.timestamps
    end
  end
end
