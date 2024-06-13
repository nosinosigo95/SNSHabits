class Habit < ApplicationRecord
  has_many :effects, through: :effect_habits
  has_many :effect_habits
  has_many :sources
  belongs_to :user

  accepts_nested_attributes_for :effect_habits
end
