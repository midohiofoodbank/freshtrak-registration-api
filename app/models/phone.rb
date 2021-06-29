# frozen_string_literal: true

# Phone for Household Member
class Phone < ApplicationRecord
  belongs_to :contact, inverse_of: :phones

  # use this validator for phone
  # validates :phone, format: { with: /\A\d{10}\z/ }, allow_blank: true
  validates :phone, presence: true
  validates :phone, uniqueness: true
end
