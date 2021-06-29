# frozen_string_literal: true

module Api
  # Exposes the Phones of user
  class PhonesController < Api::BaseController
    before_action :find_contact, only: %i[create index]
    before_action :find_phone, only: %i[show update delete]

    # GET  api/phones
    def index
      @phone = @contact.phones

      if @phone.present?
        render json: serialized_phone
      else
        render json: {}, status: :not_found
      end
    end

    # POST  api/phones
    def create
      @phone = Phone.new(phone_params)
      if @phone.save
        render json: serialized_phone
      else
        render json: { errors: @phone.errors }, status: :unprocessable_entity
      end
    end

    # GET  api/phones/:id
    def show
      if @phone
        render json: serialized_phone
      else
        render json: {}, status: :not_found
      end
    end

    # PUT/POST/PATCH  api/phones/:id
    def update
      if @phone.update(phone_params)
        render json: serialized_phone
      else
        render json: @phone.errors, status: :unprocessable_entity
      end
    end

    # DELETE  api/emails/:id
    def delete
      if @phone.destroy
        render json: { deleted: true }
      else
        render json: @phone.errors, status: :unprocessable_entity
      end
    end

    private

    def find_phone
      @phone = Phone.find_by(id: params[:id])
    end

    def find_contact
      @contact = current_user.person.contacts
                             .where(contact_type: 'phone').first_or_create
    end

    # Only allow a trusted parameter "white list" through.
    def phone_params
      permit_params = params.require(:phone).permit(
        :phone, :is_primary, :permission_to_phone
      )
      permit_params = permit_params.merge(contact_id: @contact.id) if @contact
      permit_params
    end

    def serialized_phone
      return unless @phone

      ActiveModelSerializers::SerializableResource.new(@phone).as_json
    end
  end
end
