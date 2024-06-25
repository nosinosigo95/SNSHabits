class HabitsController < ApplicationController
  before_action :set_habit, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  RELATED_HABITS_NUMBER = 4

  def new
    @form = HabitForm.new(user: current_user)
  end

  def create
    @form = HabitForm.new(attributes: habit_params, user: current_user)
    if @form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @form = HabitForm.new(habit: @habit, user: current_user)
  end

  def update
    form = HabitForm.new(attributes: habit_params, habit: @habit, user: current_user)
    if form.update
      redirect_to habit
    else
      render :edit
    end
  end

  def show
    @habit = Habit.includes(:effect_habits, :effects, :sources, :related_habits, :favorite_habits).find(params[:id])
    @habit.update(recently_viewed_time: Time.now)

    set_related_habit_table(@habit)
    set_cache_habit_id(@habit)

    @related_habits = @habit.related_habits.includes(:user, :effects).order(updated_at: :desc).limit(RELATED_HABITS_NUMBER)
  end

  def index
    @habit_index = HabitIndexForm.new(attributes: habit_index_params)
    @habit_index.valid?
    if params[:habit_index_form]
      sort = nil if @habit_index.sort.blank?
      @habits = Habit.search_attr(@habit_index, sort, current_user).page(params[:page])
    else
      @habits = Habit.search_all.page(params[:page])
    end
  end

  def destroy
    habit = Habit.find(params[:id])
    if habit.present?
      habit.destroy
      flash[:notice] = "習慣を削除しました"
    end
    redirect_to habits_url
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :scheme,
    :period_for_effect, :working_time, :viewed_count,
    :effects, :effects_ids, :circumstance, :summary,urls: [], urls_ids: [])
  end

  def habit_index_params
    if params[:habit_index_form]
      params.require(:habit_index_form).permit(:name, :effect_item,
      :period_for_effect, :created, :sort, :summary)
    else
      nil
    end
  end

  def set_cache_habit_id(habit)
    cookies.signed[:forward_habit_id] = { value: habit.id, expires: 7.days.from_now }
  end

  def set_related_habit_table(now_habit)
    old_habit_id = cookies.signed[:forward_habit_id]
    if old_habit_id.nil?
      return
    end
    if old_habit_id == now_habit.id
      return
    end
    related_habits = RelatedHabit.where(old_habit_id: old_habit_id, now_habit_id: now_habit.id)
    if related_habits.present?
      related_habits.each do |related_habit|
        related_habit.updated_at = Time.zone.now
      end
    end
    RelatedHabit.create(old_habit_id: old_habit_id, now_habit_id: now_habit.id)
  end

  def set_habit
    @habit = current_user.habits.where('id = ?', params[:id])
    if @habit.empty?
      flash[:alert] = "そのようなページはありません"
      redirect_to habits_url
    end
  end
end
