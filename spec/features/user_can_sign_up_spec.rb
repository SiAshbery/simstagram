require_relative './helpers/photo_feature_helpers_spec'

RSpec.feature "User Signup", type: :feature do

  describe "Successful Sign Up" do

    scenario "Users can Sign Up" do
      sign_up
      expect(page).to have_content("Welcome Test_User!")
    end

    scenario "Flashes a successful sign up message" do
      sign_up
      expect(page).to have_content("success: You're all signed up!")
    end

  end

  describe "Unsuccessful Sign Up" do

    describe "Mismatched Passwords" do

      scenario "Can't sign up if password doesn't match confirmation" do
        sign_up("Test_User", "test@email.com", "password", "wrongpassword")
        expect(current_path).to eq("/users/new")
      end

      scenario "Flashes a passwords don't match error message" do
        sign_up("Test_User", "test@email.com", "password", "wrongpassword")
        expect(page).to have_content("confirm_password_error: Your passwords don't match.")
      end

    end

    describe "No Name" do

      scenario "Can't sign up without a name" do
        sign_up(nil, "test@email.com", "password", "wrongpassword")
        expect(current_path).to eq("/users/new")
      end

      scenario "Flashes a no name error" do
        sign_up(nil, "test@email.com", "password", "password")
        expect(page).to have_content("no_name_error: You must enter a name.")
      end

    end

    describe "No Email" do

      scenario "Can't sign up without an email" do
        sign_up("Test_User", nil, "password", "wrongpassword")
        expect(current_path).to eq("/users/new")
      end

      scenario "Flashes a no email error" do
        sign_up("Test_User", nil, "password", "password")
        expect(page).to have_content("no_email_error: You must enter an email.")
      end

    end

    describe "No Password" do

      scenario "Can't sign up without a password" do
        sign_up("Test_User", "test@email.com", nil, nil)
        expect(current_path).to eq("/users/new")
      end

      scenario "Flashes a no password error" do
        sign_up("Test_User", "test@email.com", nil, "password")
        expect(page).to have_content("no_password_error: You must enter a password.")
      end

    end
    
  end

end
