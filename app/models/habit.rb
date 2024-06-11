class Habit < ApplicationRecord
  has_many :effects
  TEXT_MAX = 400
  validates :name, presence: true
  validates :creating_user_id, presence: true
  validates :scheme, length: {maximum: TEXT_MAX}
end
