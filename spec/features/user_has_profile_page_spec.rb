require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "User Profile Page", type: :feature do

  describe "Accessing profile from Index" do

    scenario "Can view a user's profile by clicking post author" do
      post_image
      visit("/")
      click_link("Show User")
      expect(page).to have_content("Profile of Test_User")
    end

    scenario "Can view a user's profile by clicking comment author" do
      post_comment_with_image
      visit("/")
      within("li#comment_48") do
        click_link("Show User")
      end
      expect(page).to have_content("Profile of Test_User")
    end
  end

  describe "Accessing profile from Show" do

    scenario "Can view a user's profile by clicking post author" do
      post_image
      click_link("Show User")
      expect(page).to have_content("Profile of Test_User")
    end

    scenario "Can view a user's profile by clicking comment author" do
      post_comment_with_image
      within("li#comment_49") do
        click_link("Show User")
      end
      expect(page).to have_content("Profile of Test_User")
    end

  end

  describe "Profile Content" do

    scenario "Profile Shows a user's photo's" do
      post_image
      click_link("Show User")
      expect(page).to have_content("New Photo")
      expect(page).to have_xpath("//img[contains(@src,'test_image.png')]")
    end

    scenario "Profile doesn't show other user's photo's" do
      post_image
      log_out
      sign_up("New_User", "new@email.com")
      post_image("new_image", "test_image_2.png")
      click_link("Show User")
      expect(page).not_to have_content("New Photo")
      expect(page).not_to have_xpath("//img[contains(@src,'test_image.png')]")
    end

  end

end
