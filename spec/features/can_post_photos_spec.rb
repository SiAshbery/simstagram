require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "Post a Photo", type: :feature do

  describe "Posting a Photo" do

    describe "Success" do

      scenario "Can submit a photo and view it" do
        post_image
        expect(page).to have_content("New Photo")
        expect(page).to have_xpath("//img[contains(@src,'test_image.png')]")
      end

      scenario "Flashes success message" do
        post_image
        expect(page).to have_content("success: Photo posted!")
      end

      scenario "Can see a list of photos" do
        post_image
        post_image("Second", "test_image_2.png")
        visit("/")
        expect(page).to have_content("New Photo")
        expect(page).to have_xpath("//img[contains(@src,'test_image.png')]")
        expect(page).to have_content("Second")
        expect(page).to have_xpath("//img[contains(@src,'test_image_2.png')]")
      end

      scenario "Newer photos appear first" do
        post_image
        post_image("Second", "test_image_2.png")
        visit("/")
        expect("Second by").to appear_before("New Photo by")
      end

      scenario "Photos show their created at date on index" do
        post_image
        visit("/")
        expect(page).to have_content("Posted: #{Time.now.strftime("%d/%m/%Y %H:%M")}")
      end

      scenario "Can select an image to view" do
        show_image
        expect(current_path).to eq("/photos/#{most_recent_photo.id}")
        expect(page).to have_content("New Photo")
        expect(page).to have_xpath("//img[contains(@src,'test_image.png')]")
      end

      scenario "Photos show their created at date on show" do
        show_image
        expect(page).to have_content("Posted: #{Time.now.strftime("%d/%m/%Y %H:%M")}")
      end

      scenario "Can go back to index from show" do
        show_image
        click_button("Home")
        expect(current_path).to eq("/")
      end

      scenario "Can see user name on photo" do
        post_image
        expect(page).to have_content("New Photo by Test_User")
      end
    end

    describe "Failure" do

      scenario "Can't post photo unless logged in" do
        log_out
        visit("/")
        expect(page).not_to have_content("New Photo")
        visit("photos/new")
        expect(current_path).to eq("/")
      end

      describe "Uploading non-image file" do

        scenario "Can't submit a file that's not an image" do
         post_image("text", "test.txt")
         expect(page).not_to have_content("Text")
        end

        scenario "flashes inavlid format error" do
         post_image("text", "test.txt")
         expect(page).to have_content("invalid_file_error: File must be an image.")
        end

      end

      describe "No Photo Title" do

        scenario "Can't submit photo without title" do
         post_image(nil, "test_image.png")
         expect(page).not_to have_xpath("//img[contains(@src,'test_image.png')]")
        end

        scenario "Can't submit photo without title" do
         post_image(nil, "test_image.png")
         expect(page).to have_content("no_title_error: Photo must have a title.")
        end

      end

      describe "No Photo File" do

        scenario "Can't submit photo without file" do
         post_image_without_file
         expect(page).not_to have_content("New Photo")
        end

        scenario "Can't submit photo without file" do
         post_image_without_file
         expect(page).to have_content("no_file_error: Photo must have a file.")
        end

      end
    end
  end

  describe "Deleting a Photo" do

    scenario "Users can delete a photo" do
      post_image
      click_button("Delete Photo")
      expect(page).not_to have_content("New Photo")
      expect(page).not_to have_xpath("//img[contains(@src,'test_image.png')]")
    end

    scenario "Flashes Success Message" do
      post_image
      click_button("Delete Photo")
      expect(page).to have_content("success: Photo deleted!")
    end

    scenario "Users can't delete a photo they don't own" do
      post_image
      log_out
      sign_up("New_user", "new@email.com")
      visit("/")
      click_link("Show")
      expect(page).not_to have_button("Delete Photo")
    end

  end

  describe "Editing a Photo" do

    describe "Success" do

      scenario "Users can Edit a photo" do
        edit_photo
        expect(page).to have_content("New Title")
      end

      scenario "Flashes success message" do
        edit_photo
        expect(page).to have_content("success: Photo edited!")
      end

    end

    describe "Failure" do

      scenario "Users can't Edit a photo they don't own" do
        post_image
        log_out
        sign_up("New_user", "new@email.com")
        visit("/")
        click_link("Show")
        expect(page).not_to have_button("Edit Photo")
      end

      describe "No Photo Title" do

        scenario "Can't submit photo without title" do
         edit_photo(nil)
         expect(page).to have_content("Edit Photo")
        end

        scenario "Can't submit photo without title" do
         edit_photo(nil)
         expect(page).to have_content("no_title_error: Photo must have a title.")
        end

      end

    end

  end
end
