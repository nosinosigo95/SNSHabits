class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment
      t.timestamps
    end
    add_reference :comments, :user, foreign_key: true
    add_reference :comments, :habit, foreign_key: true
  end
end
