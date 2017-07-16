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

    end

end
