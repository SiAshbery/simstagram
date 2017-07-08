class LikesController < ApplicationController

  def create
    if current_user
      @photo = Photo.find(params[:photo_id])

      @like = current_user.likes.new()
      @like.photo = @photo

      @like.save

      redirect_to photo_path(@photo)
    else
      redirect_to "/users/new"
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])

    @like = Like.where(user: current_user, photo: @photo.id).first
    @like.destroy
    
    redirect_to photo_path(@photo)
  end

end
