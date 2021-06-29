# frozen_string_literal: true

# Defines Address attributes to be returned in JSON
class AddressSerializer < ApplicationSerializer
  attributes :id, :contact_id, :line_1, :line_2, :city, :state, :zip_code
  attributes :created_at, :updated_at
end
