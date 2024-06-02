class RemoveColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    remove_column :users, :username, :string
  end
end
