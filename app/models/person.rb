# frozen_string_literal: true

# Person information
class Person < ApplicationRecord
  belongs_to :user, inverse_of: :person, optional: true
  belongs_to :family_member, inverse_of: :person, dependent: :destroy
  has_many :contacts, inverse_of: :person, dependent: :restrict_with_exception
end
