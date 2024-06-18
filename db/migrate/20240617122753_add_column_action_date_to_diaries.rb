class AddColumnActionDateToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :action_date, :date
  end
end
