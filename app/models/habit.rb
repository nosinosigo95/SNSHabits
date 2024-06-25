class Habit < ApplicationRecord
  has_many :effect_habits, dependent: :destroy
  has_many :effects, through: :effect_habits
  has_many :sources, dependent: :destroy
  has_many :favorite_habits, dependent: :restrict_with_error
  has_many :users, through: :favorite_habits
  belongs_to :user
  has_one :diary
  accepts_nested_attributes_for :effect_habits
  has_many :forward_habit_relationships, class_name: "RelatedHabit", foreign_key: "old_habit_id", dependent: :destroy
  has_many :current_habit_relationships, class_name: "RelatedHabit", foreign_key: "now_habit_id", dependent: :destroy
  has_many :related_habits, through: :current_habit_relationships, source: :old_habit

  def self.search_attr(habit_index, sort, user)
    search_attr = get_search_attr(habit_index, user)

    if search_attr.nil?
      if sort.blank?
        search_all
      else
        search_all.order(sort)
      end
    else
      if sort.blank?
        includes(:sources, :effects, :favorite_habits).where(search_attr)
      else
        includes(:sources, :effects, :favorite_habits).where(search_attr).order(sort)
      end
    end
  end

  def self.search_all
    all.includes(:sources, :effects, :favorite_habits)
  end

  def self.get_search_attr(habit_index, user)
    atr = {}

    atr['name'] = habit_index.name if habit_index.name.present?
    if habit_index.effect_item.present?
      atr['effects'] = {}
      atr['effects']['effect_item'] = habit_index.effect_item
    end
    if habit_index.period_for_effect.present?
      atr['period_for_effect'] = habit_index.period_for_effect
    end
    atr['user_id'] = user.id if habit_index.created == '1'
    atr
  end

end
Habit.private_class_method(:get_search_attr)
