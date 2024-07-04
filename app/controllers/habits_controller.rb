class HabitsController < ApplicationController
  before_action :set_habit, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  RELATED_HABITS_NUMBER = 4

  def new
    @form = HabitForm.new(user: current_user)
  end

  def create
    @form = HabitForm.new(attributes: habit_params, user: current_user)
    habit_id = @form.save
    if habit_id.present?
      flash[:notice] = "習慣を作成しました"
      redirect_to habit_url(habit_id)
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
      flash[:notice] = "習慣を更新しました"
      redirect_to habit_url(@habit.id)
    else
      render :edit
    end
  end

  def show
    @habit = Habit.includes(:effect_habits, :effects,
    :sources, :related_habits, :favorite_habits, :users, :comments).find(params[:id])
    @habit.update(recently_viewed_time: Time.now)

    if @habit.commit?
      set_related_habit_table(@habit)
      set_cache_habit_id(@habit)
    else
      if params[:comment].present? && params[:comment][:content].present?
        Comment.create(comment: params[:comment][:content],
                       habit_id: @habit.id, user_id: current_user.id)
        flash[:notice] = "コメントを作成しました。"
        redirect_to habit_path(@habit.id)
      end
      comments_output_num = 5
      @comments = @habit.comments.order(created_at: :desc).
        page(params[:page]).per(comments_output_num)
    end

    @related_habits = @habit.related_habits.includes(:user,
    :effects).order(updated_at: :desc).limit(RELATED_HABITS_NUMBER)
    @user = User.includes(:continuations, :favorite_habits).find(current_user.id)
  end

  def index
    @habit_index = HabitIndexForm.new(attributes: habit_index_params)
    @habit_index.valid?
    if params[:habit_index_form]
      if @habit_index.sort.blank?
        sort = nil
      else
        sort = @habit_index.sort
      end
      @habits = Habit.search_attr(@habit_index, sort, current_user).page(params[:page])
    else
      @habits = Habit.search_all.page(params[:page])
    end
    @user = User.includes(:continuations, :favorite_habits).find(current_user.id)
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
    :effects, :effects_ids, :circumstance, :summary, urls: [], urls_ids: [])
  end

  def habit_index_params
    if params[:habit_index_form]
      params.require(:habit_index_form).permit(:name, :effect_item,
      :period_for_effect, :created, :sort, :summary, :circumstance)
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
    else
      RelatedHabit.create(old_habit_id: old_habit_id, now_habit_id: now_habit.id)
    end
  end

  def set_habit
    @habit = Habit.find(params[:id])
    if @habit.nil? || @habit.user_id != current_user.id
      flash[:alert] = "そのようなページはありません"
      redirect_to habits_url
    end
  end
end
