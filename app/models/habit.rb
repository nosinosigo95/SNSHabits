class Habit < ApplicationRecord
  has_many :effects
  has_many :sources
  belongs_to :user
  TEXT_MAX = 400
  validates :name, presence: true
  validates :scheme, length: {maximum: TEXT_MAX}
end
