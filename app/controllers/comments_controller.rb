class CommentsController < ApplicationController

  def create
    @photo = Photo.find(params[:photo_id])

    @comment = current_user.comments.new(comment_params)
    @comment.photo = @photo
    @comment.save
    redirect_to photo_path(@photo)
  end

  def destroy
    find_comment
    @comment.destroy if comment_belongs_to_user?
    redirect_to "/"
  end

  def edit
    find_comment
  end

  def update
    find_comment
    comment_belongs_to_user? ? verify_comment_has_updated : redirect_to("/")
  end

 private
   def comment_params
     params.require(:comment).permit(:body)
   end

   def find_comment
     @comment = Comment.find(params[:id])
   end

   def verify_comment_has_updated
     if @comment.update_attributes(comment_params)
       redirect_to "/"
     else
       render 'edit'
     end
   end

end
