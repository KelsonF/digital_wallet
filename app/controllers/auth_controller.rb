class AuthController < ApplicationController
  skip_before_action :authorize_request

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = AuthenticationService.encode_token(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def register
    user = User.new(user_params)
    if user.save
      token = AuthenticationService.encode_token(user_id: user.id)
      render json: { token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
