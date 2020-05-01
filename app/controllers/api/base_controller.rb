class Api::BaseController < ApplicationController
  before_action :authenticate_user!

  private

  def authenticate_user!
    return if current_authentication?

    render json: { error: 'invalid_auth' }, status: :unauthorized
  end

  def current_authentication?
    auth_header = request.headers['authorization']

    return false if auth_header.blank?

    token = auth_header.split(/\s+/)

    return false unless token.first == 'Bearer'

    auth_token = token.last

    authenticate_token(auth_token)
  end

  def authenticate_token(token)
    auth = Authentication.authenticate_with_token(token)
    @current_user = auth&.user
    auth
  end

  def current_user
    @current_user
  end
end