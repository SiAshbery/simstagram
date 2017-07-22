class UsersController < ApplicationController

    def new
    end

    def create
      @user = User.new(user_params)
      verify_user_has_saved
    end

    def show
      find_user
      @photos = @user.photos.order("created_at DESC")
    end

    private

    def verify_user_has_saved
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "You're All Signed Up!"
        redirect_to '/'
      else
        assign_error_type
        redirect_to '/users/new'
      end
    end

    def assign_error_type
      unless :password == :password_confirmation
        flash[:error] = "Your Passwords Don't Match"
      end
    end

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
    end

end
