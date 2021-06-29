# frozen_string_literal: true

module Api
  # Exposes/Updates the Persons data
  class PeopleController < Api::BaseController
    before_action :find_person, only: %i[update show]

    # POST /api/people
    def create
      @person = Person.new(person_params)

      if @person.save
        render json: ActiveModelSerializers::SerializableResource
          .new(@person).as_json
      else
        render json: @person.errors, status: :unprocessable_entity
      end
    end

    # PUT/PATCH  /api/people
    def update
      if @person.update(person_params)
        render json: ActiveModelSerializers::SerializableResource
          .new(@person).as_json
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

    def find_person
      @person = Person.find(params['id'])
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
