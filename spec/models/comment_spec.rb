require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = create(:comment)
  end

  it "Has a body" do
    expect(@comment.body).to eq "Test Comment"
  end

  it "Has a photo" do
    expect(@comment.photo.title).to eq "Test Photo"
  end

  it "Has a user" do
    expect(@comment.user.display_name).to eq "Test_User"
  end

end
