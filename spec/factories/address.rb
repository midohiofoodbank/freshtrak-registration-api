# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    line_1 { '914 south avenue' }
    line_2 { 'apt 141' }
    city { 'secane' }
    state { 'PA' }
    zip_code { '19018' }
    created_at { Date.today.to_s.delete('-') }
    updated_at { Date.today.to_s.delete('-') }
  end
end
