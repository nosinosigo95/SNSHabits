class Diary < ApplicationRecord
  has_one :habit
  belongs_to :user

  description_max = 600
  validates :description, presence: true, length: {maximum: description_max}
  validates :doing_time, presence: true
  validates :private, inclusion: {in: [true, false]}
end
