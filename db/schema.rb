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

ActiveRecord::Schema[7.1].define(version: 2025_07_08_025904) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "agrobot_messages", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.string "role"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_agrobot_messages_on_location_id"
  end

  create_table "animal_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "animals", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.string "alias"
    t.date "birth_date"
    t.string "gender"
    t.boolean "follow"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "breed_id", null: false
    t.index ["breed_id"], name: "index_animals_on_breed_id"
    t.index ["location_id"], name: "index_animals_on_location_id"
  end

  create_table "breeds", force: :cascade do |t|
    t.string "breed_type"
    t.bigint "animal_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_group_id"], name: "index_breeds_on_animal_group_id"
  end

  create_table "crops", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.date "sowing_date"
    t.date "harvest_date"
    t.float "surface"
    t.string "kind"
    t.boolean "follow"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_crops_on_location_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "location_id"
    t.string "first_name"
    t.string "last_name"
    t.string "citizen_register"
    t.float "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["location_id"], name: "index_employees_on_location_id"
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.float "surface"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "schedulable_type", null: false
    t.bigint "schedulable_id", null: false
    t.bigint "location_id", null: false
    t.bigint "activity_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_schedules_on_activity_id"
    t.index ["location_id"], name: "index_schedules_on_location_id"
    t.index ["schedulable_type", "schedulable_id"], name: "index_schedules_on_schedulable"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.string "kind"
    t.string "status"
    t.date "date"
    t.text "notes"
    t.string "transactionable_type", null: false
    t.bigint "transactionable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transactionable_type", "transactionable_id"], name: "index_transactions_on_transactionable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "agrobot_messages", "locations"
  add_foreign_key "animals", "breeds"
  add_foreign_key "animals", "locations"
  add_foreign_key "breeds", "animal_groups"
  add_foreign_key "crops", "locations"
  add_foreign_key "locations", "users"
  add_foreign_key "schedules", "activities"
  add_foreign_key "schedules", "locations"
end
