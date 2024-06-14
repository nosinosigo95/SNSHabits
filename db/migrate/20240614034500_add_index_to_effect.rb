class AddIndexToEffect < ActiveRecord::Migration[6.1]
  def change
    add_index :effects, :effect_item, unique: true
  end
end
