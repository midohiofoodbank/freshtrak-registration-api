# frozen_string_literal: true

# Cognito token parsing
class CognitoApi
  # AWS configurations
  REGION = ENV['REGION']
  ISS = ENV['ARN']
  TOKEN_USE_CLAIM = 'id'
  RAW_KEYS = ENV['RAW_KEYS']
  # Parsing and validating the incoming Cognito token
  def parse_cognito_token(token)
    @keys = JSON.parse(RAW_KEYS)['keys']
    key_index = fetch_key_index(token)
    render_message('key index is null', 500) if key_index.nil?
    decoded_token = verify_and_decode_token(fetch_public_key(key_index), token)
    render_message('decoded token is null', 500) if decoded_token.nil?
    claims = JSON.parse(decoded_token[1])
    render_message('Invalid ISS', 500) if invalid_iss?(claims)
    claims
  end

  private

  def fetch_public_key(key_index)
    JOSE::JWK.from_map(@keys[key_index].to_hash)
  end

  def fetch_key_index(token)
    kid = fetch_kid_from(token)
    find_key_index(kid)
  end

  def fetch_kid_from(token)
    headers = JOSE::JWT.peek_protected(token)
    headers['kid']
  end

  def find_key_index(kid)
    key_index = nil
    @keys.each_with_index do |key, i|
      key_index = i if key['kid'] == kid
    end
    key_index
  end

  def verify_and_decode_token(public_key, token)
    JOSE::JWS.verify(public_key, token)
  end

  def expired_token?(claims)
    Time.now > Time.at(claims['exp'])
  end

  def invalid_iss?(claims)
    !claims['iss'] = ISS
  end
end
