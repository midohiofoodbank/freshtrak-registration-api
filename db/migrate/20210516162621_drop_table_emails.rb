# frozen_string_literal: true

# Migration to drop the emails table
class DropTableEmails < ActiveRecord::Migration[6.1]
  def change
    drop_table :emails do |t|
      t.references :location_type, foreign_key: true, null: false
      t.references :household_member, foreign_key: true, null: false
      t.string :email, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
