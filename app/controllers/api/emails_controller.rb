# frozen_string_literal: true

module Api
  # Exposes the Emails of user
  class EmailsController < Api::BaseController
    before_action :find_contact, only: %i[create index]
    before_action :find_email, only: %i[show update delete]

    # GET  api/emails
    def index
      @email = @contact.emails

      render json: serialized_email
    end

    # POST  api/emails
    def create
      @email = Email.new(email_params)
      if @email.save
        render json: serialized_email
      else
        render json: { errors: @email.errors }
      end
    end

    # GET  api/emails/:id
    def show
      if @email
        render json: serialized_email
      else
        render json: {}, status: :not_found
      end
    end

    # PUT/POST/PATCH  api/emails/:id
    def update
      if @email.update(email_params)
        render json: serialized_email
      else
        render json: @email.errors, status: :unprocessable_entity
      end
    end

    # DELETE  api/emails/:id
    def delete
      if @email.destroy
        render json: { deleted: true }
      else
        render json: @email.errors, status: :unprocessable_entity
      end
    end

    private

    def find_email
      @email = Email.find_by(id: params[:id])
    end

    def find_contact
      @contact = current_user.person.contacts
                             .where(contact_type: 'email').first_or_create
    end

    # Only allow a trusted parameter "white list" through.
    def email_params
      permit_params = params.require(:email).permit(
        :email, :is_primary, :permission_to_email
      )
      permit_params = permit_params.merge(contact_id: @contact.id) if @contact
      permit_params
    end

    def serialized_email
      return unless @email

      ActiveModelSerializers::SerializableResource.new(@email).as_json
    end
  end
end
