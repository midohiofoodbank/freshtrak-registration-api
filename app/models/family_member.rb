# frozen_string_literal: true

# A Member of a Family
class FamilyMember < ApplicationRecord
  belongs_to :family, inverse_of: :family_members
  has_one :person, inverse_of: :family_member, dependent: :destroy
end
