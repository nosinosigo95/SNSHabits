class Diary < ApplicationRecord
  belongs_to :habit
  belongs_to :user

  description_max = 600
  validates :action_date, presence: true
  validate :is_action_date_after_today
  validates :description, presence: true, length: { maximum: description_max }
  validates(
    :doing_time,
    presence: true,
    format: { with: /\A\d{1,2}:\d{1,2}\z/, message: "に時:分を入力してください" },
  )
  validate :do_not_nothing
  validates(
    :private,
    inclusion: { in: [true, false], message: "を選択してください" },
  )

  def is_action_date_after_today
    if action_date.present? && action_date > Time.now
      errors.add(:action_date, 'は、今日以前を指定してください')
    end
  end

  def do_not_nothing
    nothing_time = "00:00"
    if doing_time == nothing_time
      errors.add(:doing_time, "は1分以上にしてください")
    end
  end
  scope :continuous_habits, -> (habit_id, user_id) {
    where(["habit_id = ? AND user_id = ?", habit_id, user_id])
  }
  scope :index_for_user, -> (user_id) {
    where("user_id = ?", user_id)
  }
end
