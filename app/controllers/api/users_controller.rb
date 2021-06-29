# frozen_string_literal: true

module Api
  # Endpoints for interacting with a User
  #   handled as a singular resource
  #   where the user is inferred from the auth token
  class UsersController < Api::BaseController
    before_action :find_user, only: %i[sign_in]

    # GET /api/users/:id
    def show
      render json: serialized_user
    end

    # POST /api/users/sign_in
    def sign_in
      create_user_with_nested_models

      render json: {
        message: 'User Registered Successfully', data: serialized_user
      }, status: :ok
    rescue StandardError => e
      message = "User signin failed, Message: #{e.message}"
      Jets.logger.error message
      render json: { message: message }, status: :unprocessable_entity
    end

    private

    def create_user_with_nested_models
      ActiveRecord::Base.transaction do
        @current_user = User.new(user_type: :customer)
        @current_user.identities.new(identity_params)
        @person = @current_user.build_person
        create_contacts if @person.valid? && @person.save!
      end
    end

    def identity_params
      provider_type = if @auth['identities']
                        @auth['identities'][0]['providerName'].downcase
                      else
                        'cognito'
                      end
      {
        'provider_uid': @auth['sub'], 'provider_type': provider_type,
        'auth_hash': ''
      }
    end

    def create_contacts
      create_email
      create_phone
    end

    def create_email
      cont_obj = @person.contacts.create!(contact_type: 'email')
      Email.create!(
        contact_id: cont_obj.id, email: @auth['email'], is_primary: true
      )
    end

    def create_phone
      cont_obj = @person.contacts.create!(contact_type: 'phone')
      Phone.create!(
        contact_id: cont_obj.id, phone: @auth['phone_number'], is_primary: true
      )
    end

    def serialized_user
      ActiveModelSerializers::SerializableResource.new(current_user).as_json
    end

    def find_user
      return if current_user.blank?

      render json: { message: 'User Already Registered' }
    end
  end
end
