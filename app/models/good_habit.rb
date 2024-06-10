class GoodHabit < ApplicationRecord
  TEXT_MAX = 400
  validates :name, presence: true, uniqueness: true
  validates :creating_user_id, presence: true, uniqueness: true
  validates :scheme, length: {maximum: TEXT_MAX}
end
