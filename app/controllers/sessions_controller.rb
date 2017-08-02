class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      flash[:success] = "Signed in!"
      redirect_to '/'
    else
      # If user's login doesn't work, send them back to the login form.
      assign_error_types(user)
      redirect_to '/session/new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You're now logged out!"
    redirect_to '/'
  end

  private

  def assign_error_types(user)
    no_user_error(user)
    incorrect_password_error(user)
  end

  def no_user_error(user)
    flash[:no_user_error] = "User does not exist." unless user
  end

  def incorrect_password_error(user)
    if user
      flash[:password_error] = "Incorrect password." unless user.authenticate(params[:password])
    end
  end
end
