# frozen_string_literal: true

# Migration to crete the families table
class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.integer :seniors_in_family, null: false, default: '0'
      t.integer :adults_in_family, null: false, default: '0'
      t.integer :children_in_family, null: false, default: '0'
      t.timestamps
    end
  end
end
