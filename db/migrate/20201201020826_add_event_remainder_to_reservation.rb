# frozen_string_literal: true

# Migration to set a flag for reminder message.
class AddEventRemainderToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :remainder_sent, :boolean, default: false
  end
end
