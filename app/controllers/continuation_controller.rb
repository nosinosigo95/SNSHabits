class ContinuationController < ApplicationController
  def add
    if Habit.where('id = ?', params[:habit_id]).present?
      continuations = Continuation.where(habit_id: params[:habit_id], user_id:current_user.id)
      if continuations.empty?
        continuations = Continuation.new(habit_id: params[:habit_id], user_id: current_user.id, now: true)
        continuations.save
        flash[:notice] = "「取り組み中」に入れました"
      else
        is_renew = false
        continuations.each do |continuation|
          if !continuation.now
            continuation.now = true
            is_renew = true
          end
        end
        flash[:notice] = "「取り組み中」に入れました" if is_renew
      end
    end
    redirect_to request.referer
  end
  def delete
    continuations = Continuation.where(habit_id: params[:habit_id], user_id: current_user.id, now: true)
    if continuations.present?
      continuations.delete_all()
      flash[:notice] = "「取り組み中」から削除しました"
    end
    redirect_to request.referer
  end
end
