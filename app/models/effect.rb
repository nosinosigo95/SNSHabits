class Effect < ApplicationRecord
  has_many :effect_habits, dependent: :destroy
  has_many :habits, through: :effect_habits
  validates :effect_item, presence: true, uniqueness: true
end
