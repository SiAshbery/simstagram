def log_out
  visit("/session/destroy")
end

def sign_up (display_name = "Test_User",
             email = "test@email.com",
             password = "password",
             password_confirmation = "password")
  log_out
  visit("/")
  click_button ("Sign Up")
  fill_in "user_display_name", with: display_name
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  fill_in "user_password_confirmation", with: password_confirmation
  click_button "Submit"
end

def log_in (email = "test@email.com",
             password = "password")
  visit("/")
  click_button ("Log In")
  fill_in "email", with: email
  fill_in "password", with: password
  click_button "Submit"
end

def post_image(title = "New Photo", image = "test_image.png")
  sign_up
  visit("/")
  click_button ("New Photo")
  fill_in "photo_title", with: title
  attach_file("photo_image_file", Rails.root + "spec/support/images/#{image}")
  click_button "Save"
end

def post_image_without_file(title = "New Photo")
  sign_up
  visit("/")
  click_button ("New Photo")
  fill_in "photo_title", with: title
  click_button "Save"
end

def show_image
  post_image
  visit("/")
  within("##{most_recent_photo.id}") do
    click_link ("Show")
  end
end

def post_comment_with_image(body = "Test Comment")
  post_image
  fill_in "comment_body", with: body
  click_button "Create Comment"
end

def post_comment_without_image(body = "Test Comment")
  visit("/")
  click_link("Show")
  fill_in "comment_body", with: body
  click_button "Create Comment"
end

def edit_photo(title = "New Title")
  post_image
  click_button("Edit Photo")
  fill_in "photo_title", with: title
  click_button("Save")
end
