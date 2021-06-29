# frozen_string_literal: true

module Api
  # Exposes the Addresses of user
  class AddressesController < Api::BaseController
    before_action :find_contact, only: %i[create index]
    before_action :find_address, only: %i[show update delete]

    # GET  api/addresses
    def index
      @address = @contact.address

      if @address.present?
        render json: serialized_address
      else
        render json: {}, status: :not_found
      end
    end

    # POST api/addresses
    def create
      @address = Address.where(address_params).first_or_initialize
      if @address.save
        render json: serialized_address
      else
        render json: { errors: @address.errors }, status: :unprocessable_entity
      end
    end

    # GET /api/addresses/:id
    def show
      render json: serialized_address
    end

    # PUT /api/addresses/:id
    def update
      if @address.update(address_params)
        render json: serialized_address
      else
        render json: { errors: @address.errors }, status: :unprocessable_entity
      end
    end

    # DELETE  api/addresses/:id
    def delete
      @address.destroy

      render json: { deleted: true }
    end

    private

    def find_address
      @address = Address.find(params[:id])
    end

    def find_contact
      @contact = current_user.person.contacts
                             .where(contact_type: 'address').first_or_create
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      permit_params = params.require(:address).permit(
        :line_1, :line_2, :city, :state, :zip_code
      )
      permit_params = permit_params.merge(contact_id: @contact.id) if @contact
      permit_params
    end

    def serialized_address
      return unless @address

      ActiveModelSerializers::SerializableResource.new(@address).as_json
    end
  end
end
