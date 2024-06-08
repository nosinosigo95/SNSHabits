class GoodHabit < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :effect, presence: true
  validates :creating_user_id, presence: true, uniqueness: true
end
