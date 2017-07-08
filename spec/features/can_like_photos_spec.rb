require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "Like a Photo", type: :feature do

  scenario "Likes counter starts at 0 by default" do
    post_image
    expect(page).to have_content("0 Likes")
  end

  scenario "Can Like a photo and like counter increases by one" do
    post_image
    click_button("Like Photo")
    expect(page).not_to have_content("1 Likes")
    expect(page).to have_content("1 Like")
  end

  scenario "Counts multiple users likes" do
    post_image
    click_button("Like Photo")
    log_out
    sign_up("Second_User", "second@user.com")
    click_link("Show")
    click_button("Like Photo")
    log_out
    sign_up("Third_User", "third@user.com")
    click_link("Show")
    click_button("Like Photo")
    expect(page).to have_content("3 Likes")
  end

  scenario "Can't Like a photo when not signed in" do
    post_image
    log_out
    click_link("Show")
    click_button("Like Photo")
    expect(current_path).to eq("/users/new")
  end

  scenario "Can't Like a photo more than once" do
    post_image
    click_button("Like Photo")
    expect(page).not_to have_button("Like Photo")
  end

  scenario "Can unlike a photo" do
    post_image
    click_button("Like Photo")
    expect(page).to have_button("Unlike Photo")
    click_button("Unlike Photo")
    expect(page).to have_content("0 Likes")
  end

end
