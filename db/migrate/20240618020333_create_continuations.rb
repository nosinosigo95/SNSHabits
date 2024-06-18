class CreateContinuations < ActiveRecord::Migration[6.1]
  def change
    create_table :continuations do |t|
      t.boolean :now
      t.timestamps
    end
    add_reference :continuations, :user, foreign: true
    add_reference :continuations, :habit, foreign: true
  end
end
