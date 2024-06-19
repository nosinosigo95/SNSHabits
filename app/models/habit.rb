class Habit < ApplicationRecord
  has_many :effect_habits
  has_many :effects, through: :effect_habits
  has_many :sources
  has_many :favorite_habits
  belongs_to :user
  has_one :diary
  accepts_nested_attributes_for :effect_habits
end
