class FavoriteHabitsController < ApplicationController
  def add
    if Habit.where('id = ?', params[:habit_id]).present?
      favorite_habit = FavoriteHabit.where(habit_id: params[:habit_id], user_id:current_user.id)
      if favorite_habit.empty?
        favorite_habit = FavoriteHabit.new(habit_id: params[:habit_id], user_id:current_user.id)
        favorite_habit.save
        flash[:notice] = "お気に入りに入れました"
      end
    end
    redirect_to request.referer
  end

  def delete
    favorite_habit = FavoriteHabit.where(habit_id: params[:habit_id], user_id:current_user.id)
    if favorite_habit.present?
      favorite_habit.delete_all()
      flash[:notice] = "お気に入りから削除しました"
    end
    redirect_to request.referer
  end
end
