require "uri"
class HabitForm
  include ActiveModel::Model
  attr_accessor :name, :scheme, :period_for_effect,
  :effects, :effects_ids, :working_time, :circumstance, :urls, :urls_ids, :summary

  # Habitモデル
  SUMMARY_TEXT_MAX = 200
  NAME_TEXT_MAX = 20
  PERIOD_FOR_EFFECT_TEXT_MAX = 10
  validates :name, presence: true, length: { maximum: NAME_TEXT_MAX }
  validates :summary, presence: true, length: { maximum: SUMMARY_TEXT_MAX }
  validates :scheme, presence: true
  validates :period_for_effect, length: { maximum: PERIOD_FOR_EFFECT_TEXT_MAX }
  validate :check_commit_or_challenge
  validates :working_time, format: { with: /(|\A(\d{1,2}:\d{1,2}))\z/ }, allow_nil: true
  # Effectモデル
  validates :effects, presence: true
  validate :check_effects
  # Sourceモデル
  validate :check_urls

  delegate :persisted?, to: :habit

  def initialize(attributes: nil, habit: Habit.new, user: nil)
    @habit = habit
    @user = user
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return false if invalid?
    saved_habit = nil
    ActiveRecord::Base.transaction do
      circumstance_map = get_commit_and_challenge
      saved_habit = Habit.create!({
        name: name, scheme: scheme, period_for_effect: period_for_effect,
        working_time: working_time, user_id: user.id,
        commit: circumstance_map[:commit], challenge: circumstance_map[:challenge],
      })

      effects.split(',').map do |effect_item|
        effect_obj = Effect.find_by(effect_item: effect_item)
        if effect_obj.nil?
          effect_obj = Effect.create!(effect_item: effect_item)
        end
        EffectHabit.create(habit_id: saved_habit.id, effect_id: effect_obj.id)
      end
      urls.map do |url|
        Source.create!(url: url, habit_id: saved_habit.id) if url.present?
      end
    end
    saved_habit.id
  rescue ActiveRecord::RecordInvalid
    false
  end

  def update
    return false if invalid?
    ActiveRecord::Base.transaction do
      circumstance_map = get_commit_and_challenge
      habit.update!({
        name: name, scheme: scheme, period_for_effect: period_for_effect,
        working_time: working_time, user_id: user.id,
        commit: circumstance_map[:commit], challenge: circumstance_map[:challenge],
      })

      get_effects_items_and_ids.each do |effect_item, effect_id|
        effect_habits = EffectHabit.where(habit_id: habit.id, effect_id: effect_id)
        effect_habits.each do |effect_habit|
          effect_habit.destroy
        end
      end
      get_effects_items_and_ids.each do |effect_item, id|
        effect_obj = Effect.find_by(effect_item: effect_item)
        if effect_obj.nil?
          effect_obj = Effect.create!(effect_item: effect_item)
        end
        EffectHabit.create(habit_id: habit.id, effect_id: effect_obj.id)
      end

      get_urls_and_ids.each do |url, id|
        next if url.blank?
        if id.nil?
          Source.create!(url: url, habit_id: habit.id)
        else
          source = Source.find(id)
          source.update!(url: url, habit_id: habit.id)
        end
      end
    end
  rescue ActiveRecord::RecordInvalid
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
      effects: habit.effect_habits.map(&:effect).pluck(:effect_item).join(','),
      effects_ids: habit.effect_habits.map(&:effect).pluck(:id).join(','),
      summary: habit.summary,
      scheme: habit.scheme,
      circumstance: get_circumstance,
      working_time: habit.working_time,
      urls: habit.sources.map(&:url),
      urls_ids: habit.sources.map(&:id),
    }
  end

  def get_circumstance
    if(habit.commit)
      "commit"
    elsif(habit.challenge)
      "challenge"
    else
      circumstance
    end
  end

  def get_effects_items_and_ids
    effects_items_array = effects.split(',').map
    effects_ids_array = effects_ids.split(',').map
    effects_items_array.zip(effects_ids_array)
  end

  def get_urls_and_ids
    urls.zip(urls_ids)
  end

  def check_urls
    urls.each do |url|
      if url.empty?
        next
      end
      match_url = url.match(URI.regexp(%w(http https)))
      if match_url.nil?
        errors.add(:urls, ':urlの形式が間違っています。')
        return
      end
    end
  end

  def get_commit_and_challenge
    if circumstance == "commit"
      { commit: 1, challenge: 0 }
    elsif circumstance == "challenge"
      { commit: 0, challenge: 1 }
    end
  end

  def check_commit_or_challenge
    match_circumstance = /(challenge)|(commit)/.match(circumstance)
    errors.add(:circumstance, ":「結果済み」か「挑戦中」を選んでください。") if match_circumstance.nil?
  end

  # 文字列が5つあり、区切り文字がカンマであることをチェックする
  # 例)文字列, 文字列, 文字列, 文字列, 文字列
  # 文字列は、英数字とひらがな、カタカナ、漢字です。
  def check_effects
    ja_en_num_chr = "[0-9a-zA-Zぁ-んーァ-ヶーｱ-ﾝﾞﾟ一-龠]"
    match_url_pattern = /^#{ja_en_num_chr}+(,#{ja_en_num_chr}+){,4}$/.match(effects)
    if match_url_pattern.nil?
      errors.add(:effects, ":5つの文字列(英数字,ひらがな,カタカナ,漢字)をカンマ区切りで区切ってください。")
    end
  end
end
