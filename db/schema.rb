# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_07_01_231908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aircrafts", force: :cascade do |t|
    t.string "dips_registration_number", null: false
    t.string "dips_type", null: false
    t.string "dips_model", null: false
    t.string "dips_type_approval_number", null: false
    t.string "dips_aircraft_registration_category", null: false
    t.string "dips_designer_and_manufacturer", null: false
    t.string "dips_serial_number", null: false
    t.string "owner_manufacturer", null: false
    t.string "model_purchased", null: false
    t.date "owner_date_purchased"
    t.string "owner_name", null: false
    t.string "remote_id_registration_number", null: false
    t.string "owner_insurance_company"
    t.string "owner_policy_number"
    t.date "owner_insurance_start_date"
    t.date "owner_insurance_expiration_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dips_model_other"
    t.string "dips_type_approval_number_other"
    t.string "dips_aircraft_registration_category_other"
    t.index ["user_id"], name: "index_aircrafts_on_user_id"
  end

  create_table "avatars", force: :cascade do |t|
    t.string "image_path", null: false
    t.integer "required_login_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_inspection_items", force: :cascade do |t|
    t.string "item_name", null: false
    t.string "result", null: false
    t.string "note"
    t.bigint "daily_inspection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_inspection_id"], name: "index_daily_inspection_items_on_daily_inspection_id"
  end

  create_table "daily_inspections", force: :cascade do |t|
    t.date "inspection_date", null: false
    t.string "inspection_location", null: false
    t.string "inspector", null: false
    t.text "special_notes"
    t.bigint "aircraft_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_daily_inspections_on_aircraft_id"
  end

  create_table "flight_logs", force: :cascade do |t|
    t.date "flight_date", null: false
    t.bigint "aircraft_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_flight_logs_on_aircraft_id"
  end

  create_table "flight_records", force: :cascade do |t|
    t.string "pilot_name", null: false
    t.time "takeoff_time", null: false
    t.time "landing_time", null: false
    t.integer "flight_time"
    t.integer "total_flight_time"
    t.string "takeoff_location", null: false
    t.string "landing_location", null: false
    t.string "flight_summary", null: false
    t.boolean "has_safety_incident", null: false
    t.bigint "flight_log_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_log_id"], name: "index_flight_records_on_flight_log_id"
  end

  create_table "inspection_maintenance_items", force: :cascade do |t|
    t.date "item_date", null: false
    t.integer "item_total_flight_time"
    t.string "item_maintenance_details", null: false
    t.string "item_reson_implementation", null: false
    t.string "item_location", null: false
    t.string "item_organizer", null: false
    t.string "item_note"
    t.bigint "inspection_maintenance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspection_maintenance_id"], name: "idx_on_inspection_maintenance_id_24cdd69b05"
  end

  create_table "inspection_maintenances", force: :cascade do |t|
    t.text "special_notes"
    t.bigint "aircraft_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_inspection_maintenances_on_aircraft_id"
  end

  create_table "safety_incidents", force: :cascade do |t|
    t.string "details_issues", null: false
    t.date "details_date_resolution"
    t.string "details_processing"
    t.string "details_verifier"
    t.bigint "flight_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_record_id"], name: "index_safety_incidents_on_flight_record_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "login_count"
    t.date "last_login_date"
    t.integer "avatar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "aircrafts", "users"
  add_foreign_key "daily_inspection_items", "daily_inspections"
  add_foreign_key "daily_inspections", "aircrafts"
  add_foreign_key "flight_logs", "aircrafts"
  add_foreign_key "flight_records", "flight_logs"
  add_foreign_key "inspection_maintenance_items", "inspection_maintenances"
  add_foreign_key "inspection_maintenances", "aircrafts"
  add_foreign_key "safety_incidents", "flight_records"
end
