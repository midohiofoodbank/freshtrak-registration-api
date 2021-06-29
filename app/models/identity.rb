# frozen_string_literal: true

# Creates an Identity for external users like facebook, google..
class Identity < ApplicationRecord
  enum provider_type: {
    cognito: 'cognito',
    facebook: 'facebook'
  }
  belongs_to :user, inverse_of: :identities
end
