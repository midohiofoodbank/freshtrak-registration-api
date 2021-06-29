# frozen_string_literal: true

# Migration to add cognito user id and identity provider to User table
class AddCognitoFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :cognito_id
      t.integer :identity_provider, default: 0
    end
  end
end
