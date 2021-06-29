# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    provider_uid { 'd7db5581-e69c-4a13-95fa-a3ebdca4004b' }
    provider_type { 'cognito' }
    auth_hash { 'sample_token_hhdkfh2455' }
    created_at { Date.today.to_s.delete('-') }
    updated_at { Date.today.to_s.delete('-') }
  end
end
