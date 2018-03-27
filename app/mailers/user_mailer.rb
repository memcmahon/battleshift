class UserMailer < ApplicationMailer
  def registration_email(user)
    @user = user
    @url = "http://localhost:3000/activate/#{@user.activation_key}"
    mail(to: @user.email, subject: "Battleshift Activation Email")
  end
end
