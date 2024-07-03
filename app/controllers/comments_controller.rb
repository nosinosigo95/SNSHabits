class CommentsController < ApplicationController
  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:notice] = "コメントを削除しました。"
    end
    redirect_to request.referer
  end
end
