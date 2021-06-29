# frozen_string_literal: true

# Migration to create the contact table
class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.references :person, foreign_key: true, null: false
      t.string :contact_type, null: false
      t.timestamps
    end
  end
end
