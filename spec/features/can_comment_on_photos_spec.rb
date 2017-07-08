require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "Comment on Photo", type: :feature do

  scenario "Won't show comments section if no comments exist" do
    post_image
    expect(page).not_to have_content("Comments")
  end

  scenario "Can see user name on photo" do
    post_comment_with_image
    expect(page).to have_content("Test_User said:")
  end

  scenario "Can submit a comment and view it" do
    post_comment_with_image
    expect(page).to have_content("Test_User said: Test Comment")
  end

  scenario "Can't submit comment without body" do
    post_image
    click_button "Create Comment"
    expect(page).not_to have_content("Test_User said:")
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
    expect(page).to have_content("Test_User said: Test Comment at #{Time.now.strftime("%H:%M")} on #{Time.now.strftime("%d/%m/%Y")}" )
  end

  scenario "Can't post a comment unless logged in" do
    post_image
    log_out
    visit("/")
    click_link("Show")
    expect(page).not_to have_content("Comments")
  end

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

  scenario "Gives option toview more comments when there are more than 3" do
    post_comment_with_image
    post_comment_without_image("second")
    post_comment_without_image("third")
    expect(page).not_to have_content("Show More")
    post_comment_without_image("fourth")
    visit("/")
    expect(page).to have_content("Show More")
    click_link("Show More")
    expect(page).to have_content("fourth")
  end

end