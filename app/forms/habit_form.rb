class HabitForm
  include ActiveModel::Model

  attr_accessor :habit_name, :scheme, :period_for_effect, :creating_user_id#, :working_time, :recently_viewed_time, :viewed_count, :challenged, :commited,
  attr_accessor :effect_items

  # 習慣モデル
  TEXT_MAX = 400
  validates :name, presence: true, uniqueness: true
  validates :creating_user_id, presence: true, uniqueness: true
  validates :scheme, length: {maximum: TEXT_MAX}
  # 効果モデル
  validates :effect_items, precense:true

  delegate :persisted?, to: :habits

  def initialize(attributes = nil, habit: GoodHabit.new)
    @habit = habit
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      count = 0
      effects_max = 5
      effects = effect_items.split(',').map do |effect_item|
        if count < effect_max
          Effect.find_or_createby(effect_item: effect_item)
        end
        count += 1
      end
      habit.update!(habit_name: habit_name, scheme: scheme, period_for_effect: period_for_effect, creating_user_id: current_user.id, effects: effects)
    end
    rescue ActiveRecord::RecordInvalid
      false
    end
  end

  def to_model
    habits
  end
  attr_reader :habit
  def default_attributes
    {
      habit_name: habit.habit_name
      creating_user_id: habit.creating_user_id
      effects: habit.effects.pluck(:effect_item).join(',')
    }
  end
end
