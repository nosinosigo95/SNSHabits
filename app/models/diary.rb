class Diary < ApplicationRecord
  belongs_to :habit
  belongs_to :user

  description_max = 600
  validates :action_date, presence: true
  validates :description, presence: true, length: {maximum: description_max}
  validates :doing_time, presence: true, format: {with: /\A\d{1,2}:\d{1,2}\z/, message: "に時:分を入力してください"}
  validates :private, inclusion: {in: [true, false], message: "選択してください"}
end
