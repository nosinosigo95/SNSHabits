class Effect < ApplicationRecord
  belongs_to :habit
  validates :effect_item, presence: true
end
