class HabitIndexForm
  include ActiveModel::Model

  attr_accessor :name, :working_time, :effect_item, :period_for_effect, :created, :sort

  validates :created, inclusion: { in: ['1', '0'] }, allow_nil: true
  validates :working_time, format:{ with: /\A(|\d{1,2}:\d{1,2})\z/}, allow_nil: true

  def initialize(attributes: nil)
    attributes ||= default_attributes
    super(attributes)
  end

  private

  def default_attributes
    {
      name: name,
      working_time: working_time,
      effect_item: effect_item,
      period_for_effect: period_for_effect,
      created: created,
      sort: sort,
    }
  end
end
