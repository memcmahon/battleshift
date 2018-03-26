require "rails_helper"

describe "as a registered user" do
  describe "when i visit email" do
    it "activates my account and redirects to dashboard" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/activate/#{user.activation_key}"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Thank you! Your account is now activated.")
      expext(page).to have_content("Status: Active")
    end
  end
end
