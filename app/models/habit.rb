class Habit < ApplicationRecord
  has_many :effect_habits
  has_many :effects, through: :effect_habits
  has_many :sources
  has_many :favorite_habits
  has_many :users, through: :favorite_habits
  belongs_to :user
  has_one :diary
  accepts_nested_attributes_for :effect_habits

  def self.search_attr(habit_index, page, sort, user)
    search_attr = get_search_attr(habit_index, user)

    if search_attr.nil?
      if sort.blank?
        search_all(page)
      else
        search_all(page).order(sort)
      end
    else
      if sort.blank?
        includes(:sources, :effects).where(search_attr).page(page)
      else
        includes(:sources, :effects).where(search_attr).order(sort).page(page)
      end
    end
  end

  def self.search_all(page)
    all.includes(:sources, :effects).page(page)
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
