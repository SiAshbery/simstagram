require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "Comment on Photo", type: :feature do

  scenario "Won't show comments section if no comments exist" do
    post_image
    expect(page).not_to have_content("Comments")
  end

  describe "Successful Post" do

    scenario "Can see user name on photo" do
      post_comment_with_image
      expect(page).to have_content("Test_User said:")
    end

    scenario "Can submit a comment and view it" do
      post_comment_with_image
      expect(page).to have_content("Test_User said: Test Comment")
    end

    scenario "Can see a list of comments" do
      post_comment_with_image
      fill_in "comment_body", with: "Second Comment"
      click_button "Create Comment"
      expect(page).to have_content("Test Comment")
      expect(page).to have_content("Second Comment")
    end

    scenario "Older comments appear first" do
      post_comment_with_image
      post_comment_without_image("Second Comment")
      expect("Test Comment").to appear_before("Second Comment")
    end

    scenario "Comments show their created at date on index" do
      post_comment_with_image
      expect(page).to have_content("Test_User said: Test Comment at #{Time.now.strftime("%H:%M")} on #{Time.now.strftime("%d/%m/%Y")}")
    end

    scenario "Flases Success message" do
      post_comment_with_image
      expect(page).to have_content("success: Comment posted!")
    end

  end

  describe "Failed Post" do

    scenario "Can't post a comment unless logged in" do
      post_image
      log_out
      visit("/")
      click_link("Show")
      expect(page).not_to have_content("Comments")
    end

    scenario "Can't submit comment without body" do
      post_image
      click_button "Create Comment"
      expect(page).not_to have_content("Test_User said:")
    end

    scenario "Flases No Message Error" do
      post_image
      click_button "Create Comment"
      expect(page).to have_content("no_message_error: You must enter a message.")
    end

  end

  describe "Comments on Index" do

    scenario "Can see comments on Photo index" do
      post_comment_with_image
      visit("/")
      expect(page).to have_content("Test_User said: Test Comment")
    end

    scenario "Can see up to 3 comments on index but no more" do
      post_comment_with_image
      visit("/")
      expect(page).to have_content("Test Comment")
      post_comment_without_image("second")
      visit("/")
      expect(page).to have_content("second")
      post_comment_without_image("third")
      visit("/")
      expect(page).to have_content("third")
      post_comment_without_image("fourth")
      visit("/")
      expect(page).not_to have_content("Test_User said: fourth")
    end

    scenario "Gives option to view more comments when there are more than 3" do
      post_comment_with_image
      post_comment_without_image("second")
      post_comment_without_image("third")
      expect(page).not_to have_content("Show More")
      post_comment_without_image("fourth")
      visit("/")
      expect(page).to have_content("...")
      click_link("Show_More")
      expect(page).to have_content("fourth")
    end

  end

  describe "Deleting Comments on Show" do

    scenario "Can Delete a comment" do
      post_comment_with_image
      click_button("Delete Comment")
      expect(page).not_to have_content("Test_User said: Test Comment")
    end

    scenario "Flashes Success message" do
      post_comment_with_image
      click_button("Delete Comment")
      expect(page).to have_content("success: Comment deleted!")
    end

    scenario "Can't Delete a comment if it does not belong to user" do
      post_comment_with_image
      log_out
      click_link("Show")
      expect(page).not_to have_button("Delete Comment")
    end

  end

  describe "Deleting Comments on Index" do

    scenario "Can Delete a comment" do
      post_comment_with_image
      visit("/")
      click_button("Delete Comment")
      expect(page).not_to have_content("Test_User said: Test Comment")
    end

    scenario "Flashes Success messager" do
      post_comment_with_image
      visit("/")
      click_button("Delete Comment")
      expect(page).to have_content("success: Comment deleted!")
    end

    scenario "Can't Delete a comment if it does not belong to user" do
      post_comment_with_image
      log_out
      expect(page).not_to have_button("Delete Comment")
    end

  end

  describe "Editing Comments on Show" do

    scenario "Can Edit a comment" do
      post_comment_with_image
      click_button("Edit Comment")
      fill_in "comment_body", with: "Updated Comment"
      click_button("Save Changes")
      expect(page).to have_content("Updated Comment")
    end

    scenario "Can Edit a comment" do
      post_comment_with_image
      click_button("Edit Comment")
      fill_in "comment_body", with: "Updated Comment"
      click_button("Save Changes")
      expect(page).to have_content("success: Comment edited!")
    end

    scenario "Can't Edit a comment that does not belong to user" do
      post_comment_with_image
      log_out
      click_link("Show")
      expect(page).not_to have_content("Updated Comment")
    end

    scenario "Can't Edit a comment with empty body" do
      post_comment_with_image
      click_button("Edit Comment")
      fill_in "comment_body", with: nil
      click_button("Save Changes")
      expect(page).to have_content("Edit Comment")
    end

    scenario "Flashes no_message_error" do
      post_comment_with_image
      click_button("Edit Comment")
      fill_in "comment_body", with: nil
      click_button("Save Changes")
      expect(page).to have_content("no_message_error: You must enter a message.")
    end

  end

  describe "Editing Comments on Index" do

    scenario "Can Edit a comment" do
      post_comment_with_image
      visit("/")
      click_button("Edit Comment")
      fill_in "comment_body", with: "Updated Comment"
      click_button("Save Changes")
      expect(page).to have_content("Updated Comment")
    end

    scenario "Shows success message" do
      post_comment_with_image
      visit("/")
      click_button("Edit Comment")
      fill_in "comment_body", with: "Updated Comment"
      click_button("Save Changes")
      expect(page).to have_content("success: Comment edited!")
    end

    scenario "Can't Edit a comment that does not belong to user" do
      post_comment_with_image
      log_out
      expect(page).not_to have_content("Updated Comment")
    end

  end

end
