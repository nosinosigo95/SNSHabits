class DiariesController < ApplicationController
  def new
    @diary = Diary.new
    @diary.habit_id = params[:habit_id]
  end

  def create 
    diary = Diary.create(diary_params)
    if diary.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    diary = Diary.find(params[:id])
    if diary.update(diary_params)
      redirect_to root_url
    else
      render :edit
    end
  end

  def index
    habit_id = params[:habit_id]
    if habit_id.present?
      @diaries = current_user.diaries.where(habit_id: habit_id)
    else
      @diaries = current_user.diaries
    end
  end

  def destroy
  end

  private
    def diary_params
      params.require(:diary).permit(:description, :doing_time, :private, :action_date).merge(user_id: current_user.id)
    end
end