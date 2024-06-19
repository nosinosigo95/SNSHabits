class Habit < ApplicationRecord
  has_many :effect_habits
  has_many :effects, through: :effect_habits
  has_many :sources
  has_many :favorite_habits
  belongs_to :user
  has_one :diary
  accepts_nested_attributes_for :effect_habits

  def self.search_attr(habit_index, page, sort)
    search_attr = self.get_search_attr(habit_index)

    if search_attr.nil?
      if sort.blank?
        self.search_all(page)
      else
        self.search_all(page).order(sort)
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

  private

  def self.get_search_attr(habit_index)
    atr = {}

    atr['name'] = habit_index.name if habit_index.name.present?
    if habit_index.effect_item.present?
      atr['effects'] = {}
      atr['effects']['effect_item'] = habit_index.effect_item 
    end
    atr['period_for_effect'] = habit_index.period_for_effect if habit_index.period_for_effect.present?

    atr
  end
end
