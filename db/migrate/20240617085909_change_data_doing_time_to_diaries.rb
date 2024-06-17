class ChangeDataDoingTimeToDiaries < ActiveRecord::Migration[6.1]
  def change
    change_column :diaries, :doing_time, :text
  end
end
