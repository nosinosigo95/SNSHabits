class Habit < ApplicationRecord
  has_many :effects
  has_many :sources
  belongs_to :user
end
