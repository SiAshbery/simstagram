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
        find_photo
    end

    def destroy
      find_photo
      @photo.destroy if photo_belongs_to_user?
      redirect_to "/"
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

    def find_photo
      @photo = Photo.find(params[:id])
    end

end
