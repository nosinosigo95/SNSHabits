class Habit < ApplicationRecord
  has_many :effect_habits
  has_many :effects, through: :effect_habits
  has_many :sources
  has_many :favorite_habits
  belongs_to :user
  has_one :diary
  accepts_nested_attributes_for :effect_habits

  def self.search_attr(habit_index, page)
    includes(:sources, :effects).where(get_search_attr(habit_index)).page(page)
  end

  def self.search_all(page)
    all.includes(:sources, :effects).page(page)
  end

  private
  def get_search_attr(habit_index)
    atr = {}
    atr['effects'] = {}

    atr['name'] = habit_index.name if habit_index.name.present?
    atr['working_time'] = habit_index.working_time if habit_index.working_time.present?
    atr['effects']['effect_item'] = habit_index.effect_item if habit_index.effect_item.present?
    atr['period_for_effect'] = habit_index.period_for_effect if habit_index.period_for_effect.present?

    atr
  end
end
