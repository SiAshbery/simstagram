require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  before(:each) do
    @photo = create(:photo)
    @user = create(:user)
    @like = @user.likes.create(photo: @photo)
    session[:user_id] = @user.id
  end

  describe "POST Create" do

    it "has a 302 status code" do
      post :create, params: {
        photo_id: @photo.id,
      }
      expect(response.status).to eq(302)
    end

    it "redirects to show" do
      post :create, params: {
        photo_id: @photo.id,
      }
      expect(response).to redirect_to("/photos/#{most_recent_photo.id}")
    end

    it "assigns @like" do
      post :create, params: {
        photo_id: @photo.id,
        }
        expect(assigns(:like)).to eq(most_recent_like)
    end
  end


  describe "DELETE Destroy" do

    it "Returns a 200 status" do
      delete :destroy, params: {
        photo_id: @photo.id,
        id: @like.id
      }
      expect(response.status).to eq(302)
    end

    it "Deletes like" do
      delete :destroy, params: {
        photo_id: @photo.id,
        id: @like.id
      }
      expect(Like.last).not_to eq(@like)
    end

  end
end
