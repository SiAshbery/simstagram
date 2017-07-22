class PhotosController < ApplicationController

    before_action :authorize, only: [:create, :new, :destroy, :update]

    VALID_FILE_FORMATS = ["jpg", "jpeg", "gif", "png"]

    def new
      @photo = Photo.new
    end

    def edit
      find_photo
    end

    def update
      find_photo
      photo_belongs_to_user? ? verify_photo_has_updated : redirect_to("/")
    end

    def create
      @photo = current_user.photos.new(photo_params)
      verify_photo_has_saved
    end

    def index
      @photos = Photo.all.order("created_at DESC")
    end

    def show
      find_photo
    end

    def destroy
      find_photo
      @photo.destroy if photo_belongs_to_user?
      flash[:success] = "Photo deleted!"
      redirect_to "/"
    end

private
    def photo_params
      params.require(:photo).permit(:title, :image_file)
    end

    def verify_photo_has_saved
      if @photo.save
        flash[:success] = "Photo posted!"
        redirect_to @photo
      else
        assign_error_types
        render :new
      end
    end

    def verify_photo_has_updated
      if @photo.update_attributes(photo_params)
        flash[:success] = "Photo edited!"
        redirect_to "/"
      else
        assign_error_types
        render 'edit'
      end
    end

    def assign_error_types
      flash[:invalid_file_error] = "File must be an image." unless file_format_is_valid?
      flash[:no_title_error] = "Photo must have a title." if @photo.title == ""
      flash[:no_file_error] = "Photo must have a file." if @photo.image_file.to_s == ""
    end

    def file_format_is_valid?
      VALID_FILE_FORMATS.include?(photo_file_format)
    end

    def photo_file_format
      @photo.image_file.to_s.downcase.split(".")[-1]
    end

    def find_photo
      @photo = Photo.find(params[:id])
    end


end
