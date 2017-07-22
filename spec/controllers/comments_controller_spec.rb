require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:each) do
      @comment = create(:comment)
      @user = @comment.user
      @photo = @comment.photo
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

      it "Flashes Comment Success" do
        post :create, params: {
          photo_id: @photo.id,
          comment: {
            body: "Test Comment"
          }
        }
          expect(flash[:success]).to eq("Comment posted!")
      end

      it "Flashes No Message" do
        post :create, params: {
          photo_id: @photo.id,
          comment: {
            body: nil
          }
        }
          expect(flash[:no_message_error]).to eq("You must enter a message.")
      end

  end

  describe "DELETE Destroy" do

    it "Returns a 302 status" do
      delete :destroy, params: { photo_id: @photo.id, id: @comment.id }
      expect(response.status).to eq(302)
    end

    it "Deletes comment" do
      delete :destroy, params: { photo_id: @photo.id, id: @comment.id }
      expect(Comment.last).not_to eq(@comment)
    end

    it "Won't delete photo if it doesn't belong to the current_user" do
      @user_02 = create(:user)
      session[:user_id] = @user_02.id
      delete :destroy, params: { photo_id: @photo.id, id: @comment.id }
      expect(Comment.last).to eq(@comment)
    end

  end

  describe "UPDATE edit" do

    it "Returns a 302 status" do
      patch :update, params: { id: @comment.id, photo_id: @photo.id, comment: { body: "Updated Comment" } }
      expect(response.status).to eq(302)
    end

    it "redirects to show" do
      patch :update, params: { id: @comment.id, photo_id: @photo.id, comment: { body: "Updated Comment" } }
      expect(response).to redirect_to("/")
    end

    it "Updates @photo" do
      patch :update, params: { id: @comment.id, photo_id: @photo.id, comment: { body: "Updated Comment" } }
      expect(assigns(:comment)).to eq(@comment)
      expect(Comment.find(@comment.id).body).to eq("Updated Comment")
    end

    it "Won't update a photo if it doesn't belong to the current_user" do
      @user_02 = create(:user)
      session[:user_id] = @user_02.id
      patch :update, params: { id: @comment.id, photo_id: @photo.id, comment: { body: "Updated Comment" } }
      expect(Comment.find(@comment.id).body).not_to eq("Updated Comment")
    end

  end

end
