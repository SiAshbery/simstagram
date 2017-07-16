require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "User Profile Page", type: :feature do

  scenario "Can view a user's profile" do
    post_image
    visit("/")
    click_link("Show User")
    expect(page).to have_content("Profile of Test_User")
  end

end
