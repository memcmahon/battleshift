require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "registration email" do
    it "includes activation link" do
      user = User.create!(name: "Testy Dude", email: "email@email.com", password: "Test!")
      mail = UserMailer.registration_email(user)

      expect(mail.subject).to eq("Battleshift Activation Email")
      expect(mail.to).to eq(["email@email.com"])
      expect(mail.from).to eq(["thecaptain@battleshift.com"])
      expect(mail.body.encoded).to include("http://localhost:3000/activate/#{user.activation_key}")
      expect(mail.body.encoded).to include(user.api_key.id)
    end
  end
end