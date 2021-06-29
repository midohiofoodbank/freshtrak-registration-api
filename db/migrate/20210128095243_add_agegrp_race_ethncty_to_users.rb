# frozen_string_literal: true

# Migration to add age group, race, ethnicity and is_adult fields to User table
class AddAgegrpRaceEthnctyToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :age_group, default: 'Adult'
      t.string :race
      t.string :ethnicity
      t.boolean :is_adult
    end
  end
end
