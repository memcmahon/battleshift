class ApiController < ActionController::API
  before_action :verify_api_key

  private
    def verify_api_key
      unless ApiKey.find_by(id: request.headers["X-API-KEY"])
        render json: {message: "Unauthorized"}, status: 401
      end
    end
end
