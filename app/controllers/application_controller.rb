# frozen_string_literal: true

# Application Controller
class ApplicationController < Jets::Controller::Base
  include Error::ErrorHandler
  # include Application::ResponseHandler
  # Authenticate the incoming Cognito User
  # def cognito_user_authenticate
  #   token = request.headers['authorization']
  #   @claims = CognitoApi.new.parse_cognito_token(token)
  #   @cognito_user = User.where(
  #     user_type: :customer,
  #     cognito_id: @claims['sub']
  #   ).first
  # end
end
