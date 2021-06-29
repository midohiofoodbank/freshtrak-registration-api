# frozen_string_literal: true

# Migration to add identification field to reservations table.
class AddIdentificationCodeToReservation < ActiveRecord::Migration[6.1]
  def change
    change_table :reservations, bulk: true do |t|
      t.string :license_plate
      t.string :identification_code, null: false
    end
    add_index :reservations, :identification_code, unique: true
  end
end
