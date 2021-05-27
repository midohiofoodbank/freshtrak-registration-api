# frozen_string_literal: true

module Api
  # Exposes/Updates the Persons data
  class PeopleController < Api::BaseController
    before_action :set_person, only: %i[update show]

    # PUT/POST/PATCH  /api/person
    def update
      if @person.update(person_params)
        render json: @person
      else
        render json: @person.errors, status: :unprocessable_entity
      end
    end

    # GET /api/person
    def show
      render json:
        ActiveModelSerializers::SerializableResource
          .new(@person).as_json
    end

    private

    def set_person
      @person = current_user.person
    end

    # Only allow a trusted parameter "white list" through.
    def person_params
      params.require(:person).permit(
        :first_name, :middle_name, :last_name,
        :suffix, :date_of_birth, :gender
      )
    end
  end
end
