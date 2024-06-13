class AddUserIdTohabit < ActiveRecord::Migration[6.1]
  def change
    remove_column :habits, :creating_user_id, :integer
    add_reference :habits, :user, foreign_key: true
  end
end
