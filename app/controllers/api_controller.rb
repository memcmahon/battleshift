class ApiController < ActionController::API
  before_action :verify_api_key

  private
    def verify_api_key
      if ApiKey.find_by(id: request.headers["X-API-KEY"]).nil? || ApiKey.find_by(id: request.headers["X-API-KEY"]).status != "active"
        render json: {message: "Unauthorized"}, status: 401
      end
    end
end
