class CreateFavoriteHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_habits do |t|
      t.timestamps
    end
    add_reference :favorite_habits, :user, foreign: true
    add_reference :favorite_habits, :habit, foreign: true
  end
end
