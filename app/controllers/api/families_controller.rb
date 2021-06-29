# frozen_string_literal: true

module Api
  # Exposes the Families data
  class FamiliesController < Api::BaseController
    before_action :set_family, only: %i[update show]

    # PUT/POST/PATCH  /api/family
    def update
      if @family.update(family_params)
        render json: @family
      else
        render json: @family.errors, status: :unprocessable_entity
      end
    end

    # GET /api/family
    def show
      render json: @family
    end

    private

    def set_family
      person = current_user.person
      @family = Family.by_person_id(person.id).first
    end

    # Only allow a trusted parameter "white list" through.
    def family_params
      params.require(:family).permit(
        :seniors_in_family, :adults_in_family,
        :children_in_family
      )
    end
  end
end
