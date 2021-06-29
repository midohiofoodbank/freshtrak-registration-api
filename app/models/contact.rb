# frozen_string_literal: true

# Contact for a Household Member
class Contact < ApplicationRecord
  enum contact_type: {
    email: 'email',
    phone: 'phone',
    address: 'address'
  }
  belongs_to :person, inverse_of: :contacts

  has_many :emails, inverse_of: :contact, dependent: :restrict_with_exception
  has_many :phones, inverse_of: :contact, dependent: :restrict_with_exception
  has_one :address, inverse_of: :contact, dependent: :destroy

  # validates :contact_type, presence: true, uniqueness: true

  scope :email, -> { where(contact_type: 'email') }
  scope :phone, -> { where(contact_type: 'phone') }
  scope :address, -> { where(contact_type: 'address') }
end
