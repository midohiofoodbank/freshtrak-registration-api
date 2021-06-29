# frozen_string_literal: true

# Migration to create the emails table
class CreateTableEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :emails do |t|
      t.references :contact, foreign_key: true, null: false
      t.string :email, null: false
      t.boolean :is_primary, null: false, default: false
      t.boolean :permission_to_email, null: false, default: false
      t.index :email, unique: true
      t.timestamps
    end
  end
end
