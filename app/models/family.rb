# frozen_string_literal: true

# A collection of families
class Family < ApplicationRecord
  # Active Record implicitly creates the primary key as 'id.'

  # Determines table relationships.
  has_many :family_members, inverse_of: :family, dependent: :destroy
  has_many :contacts, inverse_of: :family, dependent: :restrict_with_exception

  scope :by_person_id, lambda { |id|
    joins(:family_members)
      .where('family_members.person_id = ?', id)
  }
end
