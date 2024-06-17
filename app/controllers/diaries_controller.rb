class DiariesController < ApplicationController
  def new
    @diary = Diary.new
    @diary.habit_id = params[:habit_id]
  end

  def create
    @diary = Diary.create(dairy_params)
    if(@diary.save)
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private
    def dairy_params
      params.require(:diary).permit(:description, :doing_time, :private, :action_date).merge(user_id: current_user.id)
    end
end
