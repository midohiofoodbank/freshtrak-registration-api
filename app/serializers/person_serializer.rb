# frozen_string_literal: true

# Defines Person attributes to be returned in JSON
class PersonSerializer < ApplicationSerializer
  attributes :id, :user_id, :first_name, :middle_name, :last_name
  attributes :suffix, :gender, :date_of_birth

  has_many :contacts, if: -> { @instance_options[:contacts] }
end