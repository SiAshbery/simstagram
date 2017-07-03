require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "User Comments", type: :feature do

  scenario "Users can comment on a photo" do
    sign_up
    show_image
    click_button("Add Comment")
    fill_in "comment_body", with: "Test Comment"
    click_button "Save Comment"
    expect(page).to have_content("Test Comment")
  end

end