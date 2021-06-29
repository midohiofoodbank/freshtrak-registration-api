# frozen_string_literal: true

# Address for Household Member
class Address < ApplicationRecord
  belongs_to :contact, inverse_of: :address

  validates :state,
            length: { is: 2 }

  validates :zip_code,
            length: { is: 5 }
end
