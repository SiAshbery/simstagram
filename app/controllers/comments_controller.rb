class CommentsController < ApplicationController
  
  def new
  end

  def create
      @user = current_user
      @post = Photo.find(params[:photo_id])
      @comment = @user.comments.create(comment_params)
 
      @comment.save
      redirect_to photo_path(@photo)
  end

private

  def comment_params
      params.require(:comment).permit(:body, :photo_id)
  end
end
