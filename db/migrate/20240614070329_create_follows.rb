class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.bigint :foller_id
      t.bigint :followed_id
      t.timestamps
    end
  end
end
