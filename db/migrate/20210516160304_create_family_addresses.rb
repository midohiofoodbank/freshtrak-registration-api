# frozen_string_literal: true

# Migration to create the addresses table
class CreateFamilyAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :contact, foreign_key: true, null: false
      t.string  :line_1, null: false
      t.string  :line_2
      t.string  :city, null: false
      t.string  :state, null: false
      t.string  :zip_code, null: false
      t.timestamps
    end
  end
end
