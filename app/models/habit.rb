class Habit < ApplicationRecord
  has_many :effect_habits, dependent: :destroy
  has_many :effects, through: :effect_habits
  has_many :sources, dependent: :destroy
  has_many :favorite_habits, dependent: :restrict_with_error
  has_many :users, through: :favorite_habits
  has_many :comments
  belongs_to :user
  has_one :diary, dependent: :restrict_with_error
  has_many(
    :forward_habit_relationships,
    class_name: "RelatedHabit",
    foreign_key: "old_habit_id",
    dependent: :destroy
  )
  has_many(
    :current_habit_relationships,
    class_name: "RelatedHabit",
    foreign_key: "now_habit_id",
    dependent: :destroy
  )
  has_many(:related_habits, through: :current_habit_relationships, source: :old_habit)

  # habit_indexはHabitIndexFormの変数です
  def self.search_attr(habit_index, sort, user)
    if sort.blank?
      includes(:sources, :effects, :favorite_habits).all.
        return_where_for_habit_index_form(habit_index, user)
    else
      includes(:sources, :effects, :favorite_habits).all.
        return_where_for_habit_index_form(habit_index, user).order({ "habits.#{sort}" => "DESC" })
    end
  end

  def self.search_all
    all.includes(:sources, :effects, :favorite_habits).where(commit: true)
  end

  scope :search_name, -> (name) {
    if name.present?
      where("name LIKE ?", "%" + name + "%")
    end
  }
  scope :search_effect, -> (effect) {
    if effect.present?
      references(:effects).where("effects.effect_item LIKE ?", "%" + effect + "%")
    end
  }
  scope :search_period_for_effect, -> (period_for_effect) {
    if period_for_effect.present?
      where(period_for_effect: period_for_effect)
    end
  }
  scope :search_using_user, -> (using_user, created) {
    if created == "1"
      where(user_id: using_user.id)
    end
  }
  scope :search_commit, -> (circumstance) {
    if circumstance == "commit"
      where(commit: true)
    end
  }
  scope :search_challenge, -> (circumstance) {
    if circumstance == "challenge"
      where(challenge: true)
    end
  }
  # habit_indexはHabitIndexFormの変数です
  def self.return_where_for_habit_index_form(habit_index, user)
    name = habit_index.name
    effect = habit_index.effect_item
    period_for_effect = habit_index.period_for_effect
    created = habit_index.created
    circumstance = habit_index.circumstance
    search_name(name).search_effect(effect).
      search_period_for_effect(period_for_effect).
      search_using_user(user, created).
      search_commit(circumstance).
      search_challenge(circumstance)
  end
end
