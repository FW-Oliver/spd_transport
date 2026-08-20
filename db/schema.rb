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

ActiveRecord::Schema[8.1].define(version: 2026_08_18_224644) do
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

  add_foreign_key "locations", "organizations"
  add_foreign_key "sessions", "users"
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
