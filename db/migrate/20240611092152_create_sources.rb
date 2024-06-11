class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources do |t|
      t.string :url
      t.references :habit, foreign_key: true
      t.timestamps
    end
  end
end
