class LikesController < ApplicationController
  def create
    if current_user
      assign_photo

      build_new_like unless user_has_liked_photo?

      redirect_back(fallback_location: root_path)
    else
      redirect_to "/users/new"
    end
  end

  def destroy
    assign_photo

    @like = Like.where(user: current_user, photo: @photo.id).first
    @like.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def build_new_like
    @like = current_user.likes.new()
    @like.photo = @photo

    @like.save
  end

  def assign_photo
    @photo = Photo.find(params[:photo_id])
  end
end
