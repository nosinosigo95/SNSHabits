class HabitsController < ApplicationController
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
    @habit = current_user.posts.find(params[:id], user: current_user)
    @form = HabitForm.new(habit: @habit)
  end
  def update
    @habit = current_user.posts.find(params[:id], user: current_user)
    @form = HabitForm.new(habit_params, habit: @habit)
    if @form.save
      redirect_to @habit
    else
      render :edit
    end
  end

  private
  def habit_params
    params.require(:habit).permit(:name, :scheme, :period_for_effect, :working_time, :recently_viewed_time, :viewed_count, :challenged, :commited, :effects)
  end
end
