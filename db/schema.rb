# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140530021255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "feedbacks", force: true do |t|
    t.string   "punctuality"
    t.string   "communication"
    t.string   "time_management"
    t.string   "service_quality"
    t.string   "areas_for_improvement"
    t.string   "areas_worthy_of_praise"
    t.string   "other_comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "housekeeper_id"
    t.integer  "time_slot_id"
  end

  add_index "feedbacks", ["housekeeper_id"], name: "index_feedbacks_on_housekeeper_id", using: :btree
  add_index "feedbacks", ["time_slot_id"], name: "index_feedbacks_on_time_slot_id", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "housekeepers", force: true do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "contact"
    t.text     "address"
    t.string   "postal"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "experience_level"
    t.string   "secondary_contact"
    t.string   "language_spoken"
    t.text     "special_remarks"
    t.date     "date_joined"
  end

  create_table "housekeepers_locations", force: true do |t|
    t.integer "housekeeper_id"
    t.integer "location_id"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", force: true do |t|
    t.string  "name"
    t.integer "session_type"
    t.integer "hours"
    t.integer "price_cents",    default: 0,     null: false
    t.string  "price_currency", default: "USD", null: false
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "intro_text"
    t.string   "intro_image"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.string   "ip_address"
    t.string   "express_token"
    t.string   "express_payer_id"
    t.integer  "user_id"
    t.integer  "package_id"
    t.string   "status",           default: "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "special_hours", force: true do |t|
    t.integer  "user_id"
    t.integer  "hour"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", force: true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "category",       default: "booked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "housekeeper_id"
    t.text     "remarks"
  end

  add_index "time_slots", ["housekeeper_id"], name: "index_time_slots_on_housekeeper_id", using: :btree
  add_index "time_slots", ["user_id"], name: "index_time_slots_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "address"
    t.string   "unit"
    t.string   "postal"
    t.string   "instruction"
    t.string   "alternative_contact_number"
    t.string   "contact_number"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_packages", force: true do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
