class HabitsController < ApplicationController
  before_action :set_habit, only: [:edit, :update]
  before_action :authenticate_user!
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
    @form = HabitForm.new(attributes: habit_params, habit: @habit, user: current_user)
    if @form.update
      redirect_to @habit
    else
      render :edit
    end
  end

  def show
    @habit = Habit.find(params[:id])
    @habit.update(recently_viewed_time: Time.now)
  end

  def index
    @habit_index = HabitIndexForm.new(attributes: habit_index_params)
    @habit_index.valid?
    if params[:habit_index_form]
      sort = nil if @habit_index.sort.blank?
      @habits = Habit.search_attr(@habit_index, params[:page], sort, current_user)
    else
      @habits = Habit.search_all(params[:page])
    end
  end

  def destroy
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :scheme,
    :period_for_effect, :working_time, :viewed_count,
    :effects, :effects_ids, :circumstance, urls: [], urls_ids: [])
  end

  def habit_index_params
    if params[:habit_index_form]
      params.require(:habit_index_form).permit(:name, :effect_item,
      :period_for_effect, :created, :sort)
    else
      nil
    end
  end

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end
end
