# frozen_string_literal: true

# Defines User attributes to be returned in JSON
class UserSerializer < ApplicationSerializer
  attributes :id, :user_type

  has_many :identities
  has_many :authentications
  has_many :reservations
  has_one :person
end
