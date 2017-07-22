require 'rails_helper'
require_relative './helpers/photos_controller_helpers_spec'

RSpec.describe PhotosController, type: :controller do

    before(:each) do
        @user = create(:user)
        @photo = @user.photos.create({title: "New Photo", image_file: upload_file  })
        session[:user_id] = @user.id
    end

    describe "GET index" do

        it "has a 200 status code" do
            get :index
            expect(response.status).to eq(200)
        end

        it "renders the index template" do
            get :index
            expect(response).to render_template("index")
        end

        it "assigns @photos" do
            get :index
            expect(assigns(:photos)).to eq([@user.photos[0]])
        end
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
            get :show, params: { id: @user.photos[0].id }
            expect(response.status).to eq(200)
        end

        it "renders the show template" do
            get :show, params: { id: @user.photos[0].id }
            expect(response).to render_template("show")
        end

        it "assigns @photo" do
            get :show, params: { id: @user.photos[0].id }
            expect(assigns(:photo)).to eq(@user.photos[0])
        end

    end

    describe "POST Create" do

      describe "success" do

        it "has a 302 status code" do
            post :create, params: { photo: {title: "New Photo", image_file: upload_file  } }
            expect(response.status).to eq(302)
        end

        it "redirects to show" do
            post :create, params: { photo: {title: "New Photo", image_file: upload_file  } }
            expect(response).to redirect_to("/photos/#{most_recent_photo.id}")
        end

        it "assigns @photo" do
            post :create, params: { photo: {title: "New Photo", image_file: upload_file  } }
            expect(assigns(:photo)).to eq(most_recent_photo)
        end

        it "Flashes success message" do
            post :create, params: { photo: {title: "New Photo", image_file: upload_file  } }
            expect(flash[:success]).to eq("Photo posted!")
        end

      end

      describe "failure" do

        describe "Invalid format" do

          it "redirects to new" do
              post :create, params: { photo: {title: "New Photo", image_file: upload_file('test.txt') } }
              expect(response).to render_template("new")
          end

          it "flashes invalid_format_error" do
              post :create, params: { photo: {title: "New Photo", image_file: upload_file('test.txt') } }
              expect(flash[:invalid_format_error]).to eq("File must be an image.")
          end

        end

        describe "No Title" do

          it "redirects to new" do
              post :create, params: { photo: {title: nil, image_file: upload_file } }
              expect(response).to render_template("new")
          end

          it "flashes invalid_format_error" do
              post :create, params: { photo: {title: nil, image_file: upload_file } }
              expect(flash[:no_title_error]).to eq("Photo must have a title.")
          end

        end

      end

    end

    describe "DELETE Destroy" do

      it "Returns a 302 status" do
        delete :destroy, params: { id: @photo.id }
        expect(response.status).to eq(302)
      end

      it "Deletes Photo" do
        delete :destroy, params: { id: @photo.id }
        expect(Photo.last).not_to eq(@photo)
      end

      it "Won't delete photo if it doesn't belong to the current_user" do
        @user_02 = create(:user)
        session[:user_id] = @user_02.id
        delete :destroy, params: { id: @photo.id }
        expect(Photo.last).to eq(@photo)
      end

    end

    describe "UPDATE edit" do

      it "Returns a 302 status" do
        patch :update, params: { id: @photo.id, photo: { title: "Updated Photo" } }
        expect(response.status).to eq(302)
      end

      it "redirects to show" do
        patch :update, params: { id: @photo.id, photo: { title: "Updated Photo" } }
        expect(response).to redirect_to("/")
      end

      it "Updates @photo" do
        patch :update, params: { id: @photo.id, photo: { title: "Updated Photo" } }
        expect(assigns(:photo)).to eq(@photo)
        expect(Photo.find(@photo.id).title).to eq("Updated Photo")
      end

      it "Won't update a photo if it doesn't belong to the current_user" do
        @user_02 = create(:user)
        session[:user_id] = @user_02.id
        patch :update, params: { id: @photo.id, photo: { title: "Updated Photo" } }
        expect(Photo.find(@photo.id).title).not_to eq("Updated Photo")
      end

    end

end
