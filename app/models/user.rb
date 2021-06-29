# frozen_string_literal: true

# User
#   grants access to the api through authentications
#   stores identifying information for a reservation
class User < ApplicationRecord
  enum user_type: {
    guest: 'guest',
    customer: 'customer'
  }

  enum identity_provider: {
    Guest: 0,
    Facebook: 1,
    Email_login: 2
  }

  has_many :identities, inverse_of: :user, dependent: :restrict_with_exception
  has_many :authentications, inverse_of: :user, dependent: :destroy
  has_many :reservations, inverse_of: :user, dependent: :restrict_with_exception
  has_one :credential, inverse_of: :user, dependent: :destroy
  has_one :user_detail, inverse_of: :user, dependent: :destroy
  has_one :person, inverse_of: :user, dependent: :destroy

  before_validation :set_identification_code, on: :create
  before_validation :clean_phone
  after_commit :sync_to_pantry_trak, on: :update

  validates :identification_code, presence: true,
                                  uniqueness: { case_sensitive: true }
  validates :phone, format: { with: /\A\d{10}\z/ }, allow_blank: true

  validates :credential_id, presence: true, allow_blank: true

  # Cognito user creation - we are no longer using this method
  # def self.create_cognito_user(claims, identities)
  #   identity_value = 2
  #   if identities.present?
  #     provider = identities[0]['providerName']
  #     identity_value = 1 if provider == 'Facebook'
  #   end
  #   User.create(
  #     user_type: :customer, cognito_id: claims['sub'],
  #     identity_provider: identity_value
  #   )
  # end

  private

  def set_identification_code
    loop do
      self.identification_code = SafeRandom.generate_code(6)

      break unless User.find_by(identification_code: identification_code)
    end
  end

  def clean_phone
    return unless phone && phone_changed?

    self.phone = phone.gsub(/\D/, '')
  end

  # TODO ::  this method needs to be updated as per new Data Model changes to sync_to_pantry_trak
  # def sync_to_pantry_trak
  #   PantryTrak::Client.new.create_user(self)
  # end
end
