# frozen_string_literal: true

# Reserves a slot at an agency event for a user
class Reservation < ApplicationRecord
  belongs_to :user, inverse_of: :reservations

  before_validation :set_identification_code, on: :create
  validates :identification_code, presence: true,
                                  uniqueness: { case_sensitive: true }

  after_commit :sync_to_pantry_trak, on: :create

  def self.create_new_reservation(reservation_params)
    CreateReservation.new(
      user_id: reservation_params[:user_id],
      event_date_id: reservation_params[:event_date_id],
      event_slot_id: reservation_params[:event_slot_id]
    ).call
  end

  private

  def set_identification_code
    loop do
      self.identification_code = SafeRandom.generate_code(6)

      break unless Reservation.find_by(identification_code: identification_code)
    end
  end

  def sync_to_pantry_trak
    PantryTrak::Client.new.create_reservation(
      id, user_id, event_date_id, event_slot_id
    )
  end
end
