require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "User Log In", type: :feature do

  scenario "Users can Log in" do
    sign_up
    log_out
    log_in
    expect(page).to have_content("Welcome Test_User!")
  end

  scenario "Flashes success message when logged in" do
    sign_up
    log_out
    log_in
    expect(page).to have_content("success: Signed in!")
  end

  # scenario "Can't log in if password is wrong" do
  #   sign_up
  #   log_out
  #   log_in("test@email.com", "wrongpassword")
  #   expect(current_path).to eq("/session/new")
  # end
  #
  # scenario "Flashes incorrect password message" do
  #   sign_up
  #   log_out
  #   log_in("test@email.com", "wrongpassword")
  #   expect(page).to have_content("password_error: Incorrect password.")
  # end

  scenario "Can't log in if email is wrong" do
    sign_up
    log_out
    log_in("wrong@email.com", "password")
    expect(current_path).to eq("/session/new")
  end

  scenario "Flashes no user message" do
    sign_up
    log_out
    log_in("wrong@email.com", "password")
    expect(page).to have_content("no_user_error: User does not exist.")
  end

  # scenario "Can't log in if email and password is wrong" do
  #   sign_up
  #   log_out
  #   log_in("wrong@email.com", "wrongpassword")
  #   expect(current_path).to eq("/session/new")
  # end
  #
  # scenario "Flashes all error messages" do
  #   sign_up
  #   log_out
  #   log_in("wrong@email.com", "wrongpassword")
  #   expect(page).to have_content("no_user_error: User does not exist.")
  #   expect(page).to have_content("password_error: Incorrect password.")
  # end

end
