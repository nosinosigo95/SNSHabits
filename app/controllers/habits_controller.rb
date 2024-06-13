class HabitsController < ApplicationController
  before_action :set_habit, only:[:edit, :update]

  def new
    @form = HabitForm.new(user: current_user)
  end
  def create
    @form = HabitForm.new(habit_params, user: current_user)
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
    @form = HabitForm.new(habit_params, habit: @habit, user: current_user)
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

  private
  def habit_params
    params.require(:habit).permit(:name, :scheme, :period_for_effect, :working_time, :viewed_count, :effects, :effects_ids, :circumstance, urls: [], urls_ids: [])
  end
  def set_habit
    @habit = current_user.habits.find(params[:id])
  end
end
