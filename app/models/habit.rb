class Habit < ApplicationRecord
  has_many :effects
  belongs_to :user
  TEXT_MAX = 400
  validates :name, presence: true
  validates :scheme, length: {maximum: TEXT_MAX}
end
