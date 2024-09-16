class RegistrationController < ApplicationController
  skip_before_action :authorize_request!

  def create
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
    params.permit(:name, :email, :password)
  end
end
