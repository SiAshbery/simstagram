require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:each) do
        @comment = create(:comment)
        @user = @comment.user
        @photo = @comment.photo
        session[:user_id] = @user.id
    end

  describe "GET #new" do
    it "returns http success" do
      get :new, photo_id: @photo.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      post :create, photo_id: @photo.id, params: { comment: {body: "Lorem Ipsum", photo_id: @photo.id  } }
      expect(response.status).to eq(302)
    end
  end

end
