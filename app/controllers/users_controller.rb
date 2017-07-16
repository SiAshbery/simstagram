class UsersController < ApplicationController

    def new
    end

    def create
      @user = User.new(user_params)
      verify_user_has_saved
    end

    def show
      find_user
    end

    private

    def verify_user_has_saved
      if @user.save
        session[:user_id] = @user.id
        redirect_to '/'
      else
        redirect_to '/users/new'
      end
    end

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
    end

end
