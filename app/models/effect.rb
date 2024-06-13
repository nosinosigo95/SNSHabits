class Effect < ApplicationRecord
  has_many :habits, through: :effect_habits
  has_many :effect_habits
  validates :effect_item, presence: true
end
