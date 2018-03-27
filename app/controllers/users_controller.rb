class UsersController < ApplicationController

  def show
    @user = User.find(current_user[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      UserMailer.registration_email(@user).deliver_now
      flash[:notice] = "Logged in as #{@user.name}"
      redirect_to '/dashboard'
    else
      flash[:notice] = "Something went wrong - try again!"
      render :new
    end
  end

  def update
    user = User.find_by(activation_key: params[:activation_key])
    user.update(activated: true)
    user.save
    flash[:notice] = "Thank you! Your account is now activated."
    redirect_to "/dashboard"
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password)
    end
end
