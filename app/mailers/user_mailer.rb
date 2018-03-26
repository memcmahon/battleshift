class UserMailer < ApplicationMailer
  def registration_email(user)
    @user = user
    @url = "http://localhost:3000/activate/#{@user.id}"
    mail(to: @user.email, subject: "Battleshift Activation Email")
  end
end
