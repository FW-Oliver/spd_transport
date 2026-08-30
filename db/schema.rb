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

ActiveRecord::Schema[8.1].define(version: 2026_08_30_032434) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "information_pages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "organization_id", null: false
    t.boolean "published"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_information_pages_on_organization_id"
  end

  create_table "locations", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "organization_id", null: false
    t.string "qr_token"
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_locations_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "timezone_preference"
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "transport_activities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "location_id", null: false
    t.integer "organization_id", null: false
    t.datetime "performed_at", null: false
    t.integer "transport_request_id"
    t.integer "transporter_action_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["location_id"], name: "index_transport_activities_on_location_id"
    t.index ["organization_id"], name: "index_transport_activities_on_organization_id"
    t.index ["transport_request_id"], name: "index_transport_activities_on_transport_request_id"
    t.index ["transporter_action_id"], name: "index_transport_activities_on_transporter_action_id"
    t.index ["user_id"], name: "index_transport_activities_on_user_id"
  end

  create_table "transport_requests", force: :cascade do |t|
    t.datetime "accepted_at"
    t.integer "accepted_by_id"
    t.datetime "arrived_at"
    t.integer "arrived_by_id"
    t.datetime "cancelled_at"
    t.integer "cancelled_by_id"
    t.datetime "completed_at"
    t.integer "completed_by_id"
    t.datetime "created_at", null: false
    t.datetime "in_transit_at"
    t.integer "in_transit_by_id"
    t.integer "location_id", null: false
    t.integer "organization_id", null: false
    t.datetime "requested_at", null: false
    t.string "requested_by_name", null: false
    t.string "status", default: "requested", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_by_id"], name: "index_transport_requests_on_accepted_by_id"
    t.index ["arrived_by_id"], name: "index_transport_requests_on_arrived_by_id"
    t.index ["cancelled_by_id"], name: "index_transport_requests_on_cancelled_by_id"
    t.index ["completed_by_id"], name: "index_transport_requests_on_completed_by_id"
    t.index ["in_transit_by_id"], name: "index_transport_requests_on_in_transit_by_id"
    t.index ["location_id"], name: "index_transport_requests_on_location_id"
    t.index ["organization_id"], name: "index_transport_requests_on_organization_id"
  end

  create_table "transporter_actions", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.integer "organization_id", null: false
    t.integer "position", default: 0, null: false
    t.boolean "requires_photo", default: false, null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_transporter_actions_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.integer "organization_id", null: false
    t.string "password_digest", null: false
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "information_pages", "organizations"
  add_foreign_key "locations", "organizations"
  add_foreign_key "sessions", "users"
  add_foreign_key "transport_activities", "locations"
  add_foreign_key "transport_activities", "organizations"
  add_foreign_key "transport_activities", "transport_requests"
  add_foreign_key "transport_activities", "transporter_actions"
  add_foreign_key "transport_activities", "users"
  add_foreign_key "transport_requests", "locations"
  add_foreign_key "transport_requests", "organizations"
  add_foreign_key "transport_requests", "users", column: "accepted_by_id"
  add_foreign_key "transport_requests", "users", column: "arrived_by_id"
  add_foreign_key "transport_requests", "users", column: "cancelled_by_id"
  add_foreign_key "transport_requests", "users", column: "completed_by_id"
  add_foreign_key "transport_requests", "users", column: "in_transit_by_id"
  add_foreign_key "transporter_actions", "organizations"
  add_foreign_key "users", "organizations"
end
