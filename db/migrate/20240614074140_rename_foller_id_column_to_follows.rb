class RenameFollerIdColumnToFollows < ActiveRecord::Migration[6.1]
  def change
    rename_column :follows, :foller_id, :follower_id
  end
end
