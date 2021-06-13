class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.call(auth_params)
    render json: { auth_token: auth_token }
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
