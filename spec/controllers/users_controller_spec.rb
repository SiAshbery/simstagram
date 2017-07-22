require 'rails_helper'
require_relative './helpers/photos_controller_helpers_spec'

RSpec.describe UsersController, type: :controller do

  before(:each) do
      @user = create(:user)
      session[:user_id] = @user.id
  end

    describe "GET new" do

        it "has a 200 status code" do
            get :new
            expect(response.status).to eq(200)
        end

        it "renders the new template" do
            get :new
            expect(response).to render_template("new")
        end

    end

    describe "GET show" do

        it "has a 200 status code" do
            get :show, params: { id: @user.id }
            expect(response.status).to eq(200)
        end

        it "renders the show template" do
            get :show, params: { id: @user.id }
            expect(response).to render_template("show")
        end

        it "assigns @user" do
            get :show, params: { id: @user.id }
            expect(assigns(:user)).to eq(@user)
        end

    end

    describe "POST Create" do

      describe "Success" do

        it "has a 302 status code" do
            post :create, params: { user: {display_name: "Test_User",
                                    email: "test@email.com",
                                    password: "password",
                                    password_confirmation: "password" } }
            expect(response.status).to eq(302)
        end

        it "redirects to show" do
            post :create, params: { user: {display_name: "Test_User",
                                    email: "test@email.com",
                                    password: "password",
                                    password_confirmation: "password" } }
            expect(response).to redirect_to("/")
        end

        it "assigns @photo" do
            post :create, params: { user: {display_name: "Test_User",
                                    email: "test@email.com",
                                    password: "password",
                                    password_confirmation: "password" } }
            expect(session[:user_id]).to eq(most_recent_user.id)
        end

        it "Flashes Success" do
            post :create, params: { user: {display_name: "Test_User",
                                    email: "test@email.com",
                                    password: "password",
                                    password_confirmation: "password" } }
            expect(flash[:success]).to eq("You're all signed up!")
        end

      end

      describe "Failure" do

        it "redirects to new user" do
            post :create, params: { user: {display_name: "Test_User",
                                    email: "test@email.com",
                                    password: "password",
                                    password_confirmation: "wrongpassword" } }
            expect(response).to redirect_to('/users/new')
        end

        it "Flashes Mismatched Passwords" do
            post :create, params: { user: {display_name: "Test_User",
                                    email: "test@email.com",
                                    password: "password",
                                    password_confirmation: "wrongpassword" } }
            expect(flash[:confirm_password_error]).to eq("Your passwords don't match.")
        end

        it "Flashes No Name" do
            post :create, params: { user: {display_name: nil,
                                    email: "test@email.com",
                                    password: "password",
                                    password_confirmation: "password" } }
            expect(flash[:no_name_error]).to eq("You must enter a name.")
        end

        it "Flashes No Email" do
            post :create, params: { user: {display_name: "Test_User",
                                    email: nil,
                                    password: "password",
                                    password_confirmation: "password" } }
            expect(flash[:no_email_error]).to eq("You must enter an email.")
        end

        it "Flashes No Password" do
            post :create, params: { user: {display_name: "Test_User",
                                    email: "test@email.com",
                                    password: nil,
                                    password_confirmation: "password" } }
            expect(flash[:no_password_error]).to eq("You must enter a password.")
        end

      end

    end

end
