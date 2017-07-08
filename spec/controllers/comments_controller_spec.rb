require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:each) do
      @photo = create(:photo)
      @user = create(:user)
      session[:user_id] = @user.id
  end

  describe "POST Create" do

      it "has a 302 status code" do
          post :create, params: {
            photo_id: @photo.id,
            comment: {
              body: "Test Comment"
            }
          }
          expect(response.status).to eq(302)
      end

      it "redirects to show" do
          post :create, params: {
            photo_id: @photo.id,
            comment: {
              body: "Test Comment"
            }
          }
          expect(response).to redirect_to("/photos/#{most_recent_photo.id}")
      end

      it "assigns @comment" do
          post :create, params: {
            photo_id: @photo.id,
            comment: {
              body: "Test Comment"
            }
          }
          expect(assigns(:comment)).to eq(most_recent_comment)
      end

  end

end
