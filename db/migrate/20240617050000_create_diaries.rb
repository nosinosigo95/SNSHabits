class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.text :description
      t.date :doing_time
      t.boolean :private
      t.timestamps
    end
    add_reference :diaries, :user, foreign_key: true
    add_reference :diaries, :habit, foreign_key: true
  end
end
