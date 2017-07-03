require 'rails_helper'

RSpec.describe Comment, type: :model do

  before(:each) do
    @comment = create(:comment)
    @user = @comment.user
    @photo = @comment.photo
  end

  it 'should have an ID' do
      Comment.column_names.include? 'post_id'
  end

  it 'should have text field' do
    Comment.column_names.include? 'text'
  end

  it 'should have correct text' do
    expect(@comment.body).to eq("Lorem Ipsum")
  end

  it "Has the id of it's parent post" do
    expect(@comment.photo_id).to eq(@photo.id)
  end
end
