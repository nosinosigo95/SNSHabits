class AddSummaryToHabits < ActiveRecord::Migration[6.1]
  def change
    add_column :habits, :summary, :string
  end
end
