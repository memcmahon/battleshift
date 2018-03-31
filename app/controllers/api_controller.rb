class ApiController < ActionController::API
  before_action :verify_api_key, :verify_active_user

  private
    def verify_api_key
      if ApiKey.find_by(id: request.headers["X-API-KEY"]).nil? || ApiKey.find_by(id: request.headers["X-API-KEY"]).status != "active"
        render json: {message: "Unauthorized"}, status: 401
      end
    end

    def verify_active_user
      unless ApiKey.find_by(id: request.headers["X-API-KEY"]).user.activated
        render json: {message: "your account is not active, please click activation link in email"}, status: 401
      end
    end
end
