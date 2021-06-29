# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_type { 'customer' }
    created_at { Date.today.to_s.delete('-') }
    updated_at { Date.today.to_s.delete('-') }
  end
end
