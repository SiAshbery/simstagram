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
        flash[:success] = "You're all signed up!"
        redirect_to '/'
      else
        assign_error_types
        redirect_to '/users/new'
      end
    end

    def assign_error_types
      flash[:confirm_password_error] = "Your passwords don't match." unless @user.password == @user.password_confirmation
      flash[:no_name_error] = "You must enter a name." if @user.display_name == ""
      flash[:no_email_error] = "You must enter an email." if @user.email == ""
    end

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
    end

end
