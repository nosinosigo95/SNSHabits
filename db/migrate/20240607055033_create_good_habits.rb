class CreateGoodHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :good_habits do |t|
      t.string :name 
      t.text :effect
      t.text :scheme
      t.string :doing_time
      t.string :period_for_effect
      t.integer :creating_user_id
      t.timestamps
    end
  end
end
