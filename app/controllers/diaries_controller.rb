class DiariesController < ApplicationController
  before_action :authenticate_user!
  def new
    @diary = Diary.new
    @diary.habit_id = params[:habit_id]
    end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to root_url
    else
      render :edit
    end
  end

  def index
    if params[:habit].present?
      favorite_id = /\A[0-9]+\z/.match(params[:habit][:favorite_id])
      if favorite_id[0].present?
        redirect_to new_diary_url(favorite_id[0])
      end
    end

    @user_continuations = Continuation.where(user_id: current_user.id).includes(:habit)
    @user_favorites = FavoriteHabit.where(user_id: current_user.id).includes(:habit)
    if params[:continuation].present?
      continuation_habit_id = /\A[0-9]+\z/.match(params[:continuation][:habit_id])
      if continuation_habit_id[0].present?
        @diaries = current_user.diaries.where("habit_id = ?", continuation_habit_id[0]).page(params[:page])
      else
        @diaries = current_user.diaries.page(params[:page])
      end
    else
      @diaries = current_user.diaries.page(params[:page])
    end
  end
  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    flash[:notice] = "日記を削除しました"
    redirect_to diaries_url
  end

  private

  def diary_params
    params.require(:diary).permit(:description, :doing_time, :private,
      :action_date, :habit_id).merge(user_id: current_user.id)
  end
end
