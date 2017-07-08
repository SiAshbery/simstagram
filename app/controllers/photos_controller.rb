class PhotosController < ApplicationController

    before_action :authorize, only: [:create, :new]

    def new
    end

    def create
        @user = current_user
        @photo = @user.photos.new(photo_params)

        verify_photo_has_saved

    end

    def index
        @photos = Photo.all
    end

    def show
        @photo = Photo.find(params[:id])
    end

private
    def photo_params
        params.require(:photo).permit(:title, :image_file)
    end

    def verify_photo_has_saved
      if @photo.save
        redirect_to @photo
      else
        render :new
      end
    end

end
