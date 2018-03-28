class ApplicationController < ActionController::Base
  protect_from_forgery prepend: false

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end
end
