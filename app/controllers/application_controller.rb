class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    token = request.headers["Authorization"]
    decoded_token = AuthService.decode(token)
    Current.user = User.find(decoded_token["user_id"])
  rescue
    render json: { error: "Not Authorized" }, status: :unauthorized
  end
end
