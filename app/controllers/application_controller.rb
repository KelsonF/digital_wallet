class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    # Extrai o token do cabeçalho Authorization
    token = request.headers["Authorization"]&.split(" ")[1]
    decoded_token = AuthService.decode(token)
    Current.user = User.find(decoded_token["user_id"])
  end
end
