# frozen_string_literal: true

# Defines Contact attributes to be returned in JSON
class ContactSerializer < ApplicationSerializer
  attributes :id, :person_id, :contact_type, :created_at, :updated_at

  has_many :emails
  has_many :phones
  has_many :address
end
