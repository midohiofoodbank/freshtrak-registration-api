# frozen_string_literal: true

# Defining the Cognito Authorizer
class MainAuthorizer < ApplicationAuthorizer
  authorizer(
    # <= name is used as the "function" name
    name: 'Mof_auth',
    # maps to method.request.header.Authorization
    identity_source: 'Authorization',
    type: :cognito_user_pools,
    provider_arns: [
      ENV['ARN']
    ]
  )
end
