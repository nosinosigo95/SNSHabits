class GoodHabit < ApplicationRecord
  validates :name, presence: true
  validates :effect, presence: true
  validates :creating_user_id, presence: true
end
