# frozen_string_literal: true

module AuthHelper
  def sign_in_api(user)
    auth = user.authentications.create!
    request.headers.merge!(authorization: "Bearer #{auth.token}")
  end

  def cognito_sign_in(token)
    request.headers.merge!(authorization: token)
  end
end
