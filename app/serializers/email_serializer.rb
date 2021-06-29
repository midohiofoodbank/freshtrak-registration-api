# frozen_string_literal: true

# Defines Email attributes to be returned in JSON
class EmailSerializer < ApplicationSerializer
  attributes :id, :contact_id, :email, :is_primary, :permission_to_email
  attributes :created_at, :updated_at
end
