# frozen_string_literal: true

module Api
  # Allows an end user to reserve a spot at an agency event
  class ReservationsController < Api::BaseController
    before_action :set_reservation, only: %i[show delete]
    skip_before_action :authenticate_user!, only: :events_count

    # GET /api/reservations
    def index
      @reservations = Reservation.where(user_id: current_user.id)

      render json: @reservations
    end

    # GET /api/reservations/events_count
    def events_count
      @reservations = Reservation.where(event_date_id: params[:event_date_id])

      render json: { events_count: @reservations.count }
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
      result = create_new_reservation
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

    def create_new_reservation
      CreateReservation.new(
        user_id: reservation_params[:user_id],
        event_date_id: reservation_params[:event_date_id],
        event_slot_id: reservation_params[:event_slot_id]
      ).call
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.require(:reservation)
            .permit(:event_date_id, :event_slot_id)
            .merge(user_id: current_user.id)
    end
  end
end
