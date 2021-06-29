# frozen_string_literal: true

require 'jose'
require 'json'
require 'base64'
require 'date'
# Manages the user signin/signups using cognito
class CognitoAuthenticationsController < ApplicationController
  # Creating the Cognito authorizer
  authorizer 'main#Mof_auth'
  before_action :cognito_user_authenticate

  # GET /cognito_authentications/user_data
  def user_data
    if @cognito_user.present?
      render json: @cognito_user
    else
      render_message('User not found', 409)
    end
  end

  # POST /cognito_authentications/user_signup
  def user_signup
    if @cognito_user.present?
      render_user_id('User Already Registered', @cognito_user, '200')
    else
      identities = @claims['identities']
      @cognito_user = User.create_cognito_user(@claims, identities)
      if @cognito_user.present?
        render_user_id('User Registered Successfully', @cognito_user, '201')
      end
    end
  end

  # POST /cognito_authentications/user_add_details
  def user_add_details
    @cognito_user = User.where(
      user_type: :customer,
      cognito_id: @claims['sub']
    )
    if @cognito_user.update(user_params)
      create_reservation
    else
      render_message('User creation failed', 500)
    end
  end

  private

  # User reservation creation
  def create_reservation
    result = Reservation.create_new_reservation(reservation_params)
    if result.success?
      render_message('User reservation created', 200)
    else
      render_message('User already have a reservation', 401)
    end
  end

  def user_params
    params.require(:user).permit(
      :first_name, :middle_name, :last_name, :suffix, :date_of_birth,
      :gender, :phone, :permission_to_text, :email, :permission_to_email,
      :address_line_1, :address_line_2, :city, :state, :zip_code,
      :license_plate, :seniors_in_household, :adults_in_household,
      :children_in_household
    )
  end

  def reservation_params
    params.require(:reservation)
          .permit(:event_date_id, :event_slot_id)
          .merge(user_id: @cognito_user.first.id)
  end
end
