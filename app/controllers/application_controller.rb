class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
  helper_method :current_user

  def authorize
    redirect_to '/' unless current_user
  end

  def user_has_liked_photo?( photo = @photo )
    return unless current_user
    current_user.likes.any? { |like| like.photo.id == photo.id }
  end

  helper_method :user_has_liked_photo?

  def like_for_current_user_and_post(photo = @photo)
    Like.where(user: current_user, photo: photo).first
  end

  helper_method :like_for_current_user_and_post

  def photo_belongs_to_user?(photo = @photo)
    return unless current_user
    current_user.id == @photo.user.id
  end

  helper_method :photo_belongs_to_user?

end
