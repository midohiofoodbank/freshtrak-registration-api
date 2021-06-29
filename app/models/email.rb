# frozen_string_literal: true

# Email for a Household Member
class Email < ApplicationRecord
  belongs_to :contact, inverse_of: :emails

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
