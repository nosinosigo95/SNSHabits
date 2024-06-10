class HabitForm
  include ActiveModel::Model

  attr_accessor :name, :scheme, :period_for_effect, :creating_user_id, :effects#, :working_time, :recently_viewed_time, :viewed_count, :challenged, :commited,

  # 習慣モデル
  TEXT_MAX = 400
  validates :name, presence: true
  validates :creating_user_id, presence: true
  validates :scheme, length: {maximum: TEXT_MAX}
  # 効果モデル
  #validates :split_effect_items, precense: true


  def initialize(attributes = nil, habit: Habit.new)
    @habit = habit
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      count = 0
      effects_max = 5
      effects_items = effects.split(',').map do |effect_item|
        if count < effect_max
          Effect.find_or_create_by!(effect_item: effect_item)
        end
        count += 1
      end
      habit.update!(habit_name: habit_name, scheme: scheme, period_for_effect: period_for_effect, creating_user_id: current_user.id, effects: effects_items)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    habit
  end

  private

    attr_reader :habit

    def default_attributes
      {
        name: habit.name,
        creating_user_id: habit.creating_user_id,
        effects: habit.effects.pluck(:effect_item).join(','),
      }
    end
end
