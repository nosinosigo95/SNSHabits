class HabitForm
  include ActiveModel::Model

  attr_accessor :name, :scheme, :period_for_effect, :creating_user_id, :effects, :effects_ids #, :working_time, :recently_viewed_time, :viewed_count, :challenged, :commited,

  # 習慣モデル
  TEXT_MAX = 400
  validates :name, presence: true
  #validates :creating_user_id, presence: true
  validates :scheme, length: {maximum: TEXT_MAX}
  # 効果モデル
  #validates :split_effect_items, precense: true

  delegate :persisted?, to: :habit

  def initialize(attributes = nil, habit: Habit.new, user: nil)
    @habit = habit
    @user = user

    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      saved_habit = Habit.create!(name: name, scheme: scheme, period_for_effect: period_for_effect, creating_user_id: user.id)
      count = 0
      effects_max = 5
      effects.split(',').map do |effect_item|
        if count >= effects_max
          break
        end
        Effect.create!(effect_item: effect_item, habit_id: saved_habit.id)
        count += 1
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    false
  end

  def update
    return false if invalid?
    ActiveRecord::Base.transaction do
      saved_effect = habit.update!(name: name, scheme: scheme, period_for_effect: period_for_effect, creating_user_id: user.id)
      count = 0
      effects_max = 5
      effects.split(',').each do |effect_item|
        if count >= effects_max
          break
        end
        if(effect_item.id.empty?)
          Effect.create!(effect_item: effect_item, habit_id: saved_habit.id)
        else
          effect_item.update!(effect_item: effect_item, habit_id: saved_habit.id)
        end
        count += 1
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    false
  end

  def to_model
    habit
  end

  private

    attr_reader :habit, :user

    def default_attributes
      {
        name: habit.name,
        creating_user_id: user.id,
        effects: habit.effects.pluck(:effect_item).join(','),
        effects_ids: habit.effects.plunck(:id).join(','),
      }
    end
end
