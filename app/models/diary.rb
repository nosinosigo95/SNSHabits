class Diary < ApplicationRecord
  has_one :habit
  belongs_to :user

  description_max = 600
  validates :description, presence: true, length: {maximum: description_max}
  validates :doing_time, presence: true, format: {with: /\A\d{1,2}:\d{1,2}\z/, message: "時:分を入力してください"}
  validates :private, inclusion: {in: [true, false]}
end
