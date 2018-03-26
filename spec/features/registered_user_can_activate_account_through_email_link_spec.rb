require "rails_helper"

describe "as a registered user" do
  describe "when i visit email" do
    it "activates my account and redirects to dashboard" do
      user = create(:user)

      visit "/activate/#{user.activation_key}"
    end
  end
end
