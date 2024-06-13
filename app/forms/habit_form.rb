class HabitForm
  include ActiveModel::Model
  
  attr_accessor :name, :scheme, :period_for_effect, :effects, :effects_ids, :working_time, :circumstance, :urls, :urls_ids

  # Habitモデル
  SCHEME_TEXT_MAX = 400
  NAME_TEXT_MAX = 20
  PERIOD_FOR_EFFECT_TEXT_MAX = 10
  validates :name, presence: true, length: {maximum: NAME_TEXT_MAX}
  validates :scheme, length: {maximum: SCHEME_TEXT_MAX}
  validates :period_for_effect, length: {maximum: PERIOD_FOR_EFFECT_TEXT_MAX}
  validate :check_commit_or_challenge
  # Effectモデル
  validates :effects, presence: true
  validate :check_effects
  #Sourceモデル
  validate :check_urls
  
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
      circumstance_map = get_commit_and_challenge
      saved_habit = Habit.create!(name: name, scheme: scheme, period_for_effect: period_for_effect, working_time: working_time, user_id: user.id, commit: circumstance_map[:commit], challenge: circumstance_map[:challenge])

      count = 0
      effects_max = 5
      effects.split(',').map do |effect_item|
        if count >= effects_max
          break
        end
        effect_obj = Effect.create!(effect_item: effect_item)
        EffectHabit.create(habit_id: saved_habit.id, effect_id: effect_obj.id)
        count += 1
      end
      urls.map do |url|
        Source.create!(url: url, habit_id: saved_habit.id) if url.present?
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    false
  end

  def update
    return false if invalid?
    ActiveRecord::Base.transaction do
      circumstance_map = get_commit_and_challenge
      habit.update!(name: name, scheme: scheme, period_for_effect: period_for_effect, working_time: working_time, user_id: user.id, commit: circumstance_map[:commit], challenge: circumstance_map[:challenge])

      count = 0
      effects_max = 5
      get_effects_items_and_ids.each do |effect_item, id|
        if count >= effects_max
          break
        end
        if(id.nil?)
          effect_obj = Effect.create!(effect_item: effect_item)
          EffectHabit.create(habit_id: saved_habit.id, effect_id: effect_obj.id)
        else
          effect_obj = Effect.find(id)
          effect_obj.update!(effect_item: effect_item)
          EffectHabit.create(habit_id: habit.id, effect_id: effect_obj.id)
        end
        count += 1
      end

      get_urls_and_ids.each do |url, id|
        next if url.blank? 
        if(id.nil?)
          Source.create!(url: url, habit_id: habit.id)
        else
          source = Source.find(id)
          source.update!(url: url, habit_id: habit.id)
        end
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
        effects: habit.effect_habits.map(&:effect).pluck(:effect_item).join(','),
        effects_ids: habit.effect_habits.map(&:effect).pluck(:id).join(','),
        scheme: habit.scheme,
        circumstance: circumstance,
        working_time: habit.working_time,
        urls: habit.sources.map(&:url),
        urls_ids: habit.sources.map(&:id),
      }
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
        match_url = url.match(URI::regexp(%w(http https)))
        if match_url.nil?
          errors.add(:urls, ':urlの形式が間違っています。')
          return
        end
      end
    end

    def get_commit_and_challenge
      if circumstance == "commit"
        {commit: 1, challenge: 0}
      elsif circumstance == "challenge"
        {commit: 0, challenge: 1}
      end
    end

    def check_commit_or_challenge
      match_circumstance = /(challenge)|(commit)/.match(circumstance)
      errors.add(:circumstance, ":「結果済み」か「挑戦中」を選んでください。") if match_circumstance.nil?
    end

    #文字列が5つあり、区切り文字がカンマであることをチェックする
    #例)文字列, 文字列, 文字列, 文字列, 文字列
    #文字列は、英数字とひらがな、カタカナ、漢字です。
    def check_effects
      ja_en_num_chr = "[0-9a-zA-Zぁ-んーァ-ヶーｱ-ﾝﾞﾟ一-龠]"
      match_url_pattern = /^#{ja_en_num_chr}+(,#{ja_en_num_chr}+){,4}$/.match(effects)
      if match_url_pattern.nil?
        errors.add(:effects, ":5つの文字列(英数字,ひらがな,カタカナ,漢字)をカンマ区切りで区切ってください。") 
      end
    end
end
