class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_created_by_current_user, only: [:edit, :update, :destroy]
  def new
    @diary = Diary.new
    @diary.habit_id = params[:habit_id]
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      flash[:notice] = "日記を作成しました"
      redirect_to diaries_url
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
      flash[:notice] = "日記を更新しました"
      redirect_to diaries_url
    else
      render :edit
    end
  end

  def index
    if params[:habit].present?
      favorite_id = /\A[0-9]+\z/.match(params[:habit][:favorite_id])
      if favorite_id.nil? || favorite_id.empty?
        flash[:alert] = "そのようなお気に入りはありません。"
      elsif favorite_id[0].present?
        redirect_to new_diary_url(favorite_id[0])
      end
    end

    @user_continuations = Continuation.where(user_id: current_user.id).includes(:habit)
    @user_favorites = FavoriteHabit.where(user_id: current_user.id).includes(:habit)
    if params[:continuation].present?
      continuation_habit_id = /\A[0-9]+\z/.match(params[:continuation][:habit_id])
      if continuation_habit_id.nil?
        flash[:alert] = "そのような取り組み中はありません。"
      end
      if continuation_habit_id.nil? || continuation_habit_id.empty? || continuation_habit_id[0].nil?
        flash[:alert] = "そのような取り組み中はありません。"
        @diaries = Diary.index_for_user(current_user.id).includes(:habit).page(params[:page])
      elsif continuation_habit_id[0].present?
        @diaries = Diary.continuous_habits(continuation_habit_id[0],
         current_user.id).includes(:habit).page(params[:page])
      end
    else
      @diaries = Diary.index_for_user(current_user.id).includes(:habit).page(params[:page])
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    flash[:notice] = "日記を削除しました"
    redirect_to diaries_url
  end

  def is_created_by_current_user
    diary = Diary.find_by(id: params[:id])
    if diary.nil? || diary.user_id != current_user.id
      flash[:alert] = "そのようなページはありません"
      redirect_to diaries_url
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:description, :doing_time, :private,
      :action_date, :habit_id).merge(user_id: current_user.id)
  end
end
