require 'rails_helper'

describe "Visitor can register" do
  describe "when they visit root path" do
    it "they can register as a user" do
      visit root_path

      click_on "Register"

      expect(current_path).to eq("/register")

      fill_in "email", with: "test@email.com"
      fill_in "name", with: "Testy Dude"
      fill_in "password", with: "test"
      fill_in "password_confirmation", with: "test"

      click_on "Submit"

      expect(current_path).to eq("/dashboard")

      expect(page).to have_content("Logged in as Testy Dude")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
  end
end
