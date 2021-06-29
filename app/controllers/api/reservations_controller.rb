# frozen_string_literal: true

module Api
  # Allows an end user to reserve a spot at an agency event
  class ReservationsController < Api::BaseController
    before_action :set_reservation, only: %i[show delete]

    # GET /api/reservations
    def index
      @reservations = Reservation.where(user_id: current_user.id)

      render json: @reservations
    end

    # GET /api/reservations/1
    def show
      if @reservation
        render json: @reservation
      else
        render json: {}, status: :not_found
      end
    end

    # POST /api/reservations
    def create
      result = Reservation.create_new_reservation(reservation_params)
      @reservation = result.reservation
      if result.success?
        render json: @reservation, status: :created
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/reservations/1
    def delete
      if @reservation&.destroy
        render json: { deleted: true }
      else
        render json: {}, status: :forbidden
      end
    end

    private

    def set_reservation
      @reservation = Reservation.find_by(
        id: params[:id], user_id: current_user.id
      )
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.require(:reservation)
            .permit(
              :event_date_id, :event_slot_id,
              :license_plate, :identification_code
            ).merge(user_id: current_user.id)
    end
  end
end
