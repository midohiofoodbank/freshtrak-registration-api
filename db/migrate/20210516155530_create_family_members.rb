# frozen_string_literal: true

# Migration to crete the family members table
class CreateFamilyMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :family_members do |t|
      t.references :family, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.boolean :is_active, null: false, default: true
      t.boolean :is_primary_member, null: false, default: false
      t.timestamps
    end
  end
end
