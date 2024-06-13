class AddColumnsToHabit < ActiveRecord::Migration[6.1]
  def change
    rename_column :habits, :doing_time, :working_time
    add_column :habits, :recently_viewed_time, :date
    add_column :habits, :challenge, :boolean
    add_column :habits, :commit, :boolean
  end
end
