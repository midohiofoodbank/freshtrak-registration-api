# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_01_020826) do

  create_table "alt_id_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "alt_ids", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "alt_id_type_id", null: false
    t.bigint "household_member_id", null: false
    t.string "value", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["alt_id_type_id"], name: "index_alt_ids_on_alt_id_type_id"
    t.index ["household_member_id"], name: "index_alt_ids_on_household_member_id"
  end

  create_table "authentications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_authentications_on_token", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "carrier_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "communication_preference_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "communication_preferences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "household_member_id", null: false
    t.bigint "communication_preference_type_id", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["communication_preference_type_id"], name: "fk_communication_pref_type"
    t.index ["household_member_id", "communication_preference_type_id"], name: "uq_communication_pref_member", unique: true
    t.index ["household_member_id"], name: "index_communication_preferences_on_household_member_id"
  end

  create_table "credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token", null: false
    t.string "secret"
    t.boolean "expires"
    t.datetime "expires_at"
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_credentials_on_user_id", unique: true
  end

  create_table "emails", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "location_type_id", null: false
    t.bigint "household_member_id", null: false
    t.string "email", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_emails_on_email", unique: true
    t.index ["household_member_id"], name: "index_emails_on_household_member_id"
    t.index ["location_type_id"], name: "index_emails_on_location_type_id"
  end

  create_table "event_registration_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_registration_id"
    t.bigint "household_member_id"
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_registration_id"], name: "index_event_registration_members_on_event_registration_id", unique: true
    t.index ["household_member_id"], name: "index_event_registration_members_on_household_member_id", unique: true
  end

  create_table "event_registrations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "household_id"
    t.integer "event_slot_id", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "event_status_id"
    t.index ["event_status_id"], name: "fk_rails_618ce10cb0"
    t.index ["household_id"], name: "index_event_registrations_on_household_id", unique: true
  end

  create_table "event_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "household_addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "household_id"
    t.string "line_1", null: false
    t.string "line_2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip_code", null: false
    t.string "zip_4"
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.integer "deleted_by"
    t.datetime "deleted_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["household_id"], name: "index_household_addresses_on_household_id", unique: true
  end

  create_table "household_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "household_id"
    t.bigint "user_id"
    t.integer "number"
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.date "date_of_birth", null: false
    t.boolean "is_head_of_household", default: false, null: false
    t.boolean "is_active", default: true, null: false
    t.string "added_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "gender_id"
    t.bigint "suffix_id"
    t.index ["gender_id"], name: "fk_rails_2bc1598f86"
    t.index ["household_id"], name: "index_household_members_on_household_id"
    t.index ["suffix_id"], name: "fk_rails_a183117179"
    t.index ["user_id"], name: "index_household_members_on_user_id"
  end

  create_table "households", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "number", null: false
    t.string "name", null: false
    t.string "identification_code", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.integer "deleted_by"
    t.datetime "deleted_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identification_code"], name: "index_households_on_identification_code", unique: true
  end

  create_table "identities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider_uid", null: false
    t.string "provider_type", null: false
    t.string "auth_hash", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "location_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "phone_numbers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "location_type_id", null: false
    t.bigint "carrier_type_id"
    t.bigint "household_member_id", null: false
    t.string "phone_number", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrier_type_id"], name: "index_phone_numbers_on_carrier_type_id"
    t.index ["household_member_id"], name: "index_phone_numbers_on_household_member_id"
    t.index ["location_type_id"], name: "index_phone_numbers_on_location_type_id"
  end

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "event_date_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "event_slot_id"
    t.boolean "remainder_sent", default: false
    t.index ["event_date_id"], name: "index_reservations_on_event_date_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "suffixes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "description"
    t.string "image"
    t.string "phone"
    t.string "urls"
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "suffix"
    t.string "gender"
    t.string "phone"
    t.string "email"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "license_plate"
    t.integer "seniors_in_household"
    t.integer "adults_in_household"
    t.integer "children_in_household"
    t.boolean "permission_to_email"
    t.boolean "permission_to_text"
    t.date "date_of_birth"
    t.string "identification_code", null: false
    t.bigint "credential_id"
    t.bigint "user_detail_id"
    t.index ["credential_id"], name: "fk_rails_024dac10af"
    t.index ["identification_code"], name: "index_users_on_identification_code", unique: true
    t.index ["user_detail_id"], name: "fk_rails_5de4188fc5"
  end

  add_foreign_key "alt_ids", "alt_id_types"
  add_foreign_key "alt_ids", "household_members"
  add_foreign_key "authentications", "users"
  add_foreign_key "communication_preferences", "communication_preference_types"
  add_foreign_key "communication_preferences", "household_members"
  add_foreign_key "credentials", "users"
  add_foreign_key "emails", "household_members"
  add_foreign_key "emails", "location_types"
  add_foreign_key "event_registration_members", "event_registrations"
  add_foreign_key "event_registration_members", "household_members"
  add_foreign_key "event_registrations", "event_statuses"
  add_foreign_key "event_registrations", "households"
  add_foreign_key "household_addresses", "households"
  add_foreign_key "household_members", "genders"
  add_foreign_key "household_members", "households"
  add_foreign_key "household_members", "suffixes"
  add_foreign_key "household_members", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "phone_numbers", "carrier_types"
  add_foreign_key "phone_numbers", "household_members"
  add_foreign_key "phone_numbers", "location_types"
  add_foreign_key "reservations", "users"
  add_foreign_key "user_details", "users"
  add_foreign_key "users", "credentials"
  add_foreign_key "users", "user_details"
end
