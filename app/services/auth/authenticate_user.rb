class AuthenticateUser < ApplicationService
  def initialize(auth_params)
    @email = auth_params[:email]
    @password = auth_params[:password]
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: verified_user.id) if verified_user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def verified_user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
