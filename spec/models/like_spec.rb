require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @like = create(:like)
  end

  it "Has a photo" do
    expect(@like.photo.title).to eq "Test Photo"
  end

  it "Has a user" do
    expect(@like.user.display_name).to eq "Test_User"
  end
end
