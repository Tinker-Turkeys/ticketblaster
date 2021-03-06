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

ActiveRecord::Schema.define(version: 20131203184003) do

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "occurring_on"
    t.string   "location"
    t.string   "image_url"
    t.integer  "slots"
    t.boolean  "published"
    t.boolean  "public"
    t.text     "custom_fields_json"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "canceled",           default: false
    t.integer  "user_id"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "invitees", force: true do |t|
    t.integer "event_id"
    t.integer "registration_id"
    t.string  "name"
    t.string  "email"
    t.string  "phone_number"
  end

  add_index "invitees", ["event_id"], name: "index_invitees_on_event_id"
  add_index "invitees", ["registration_id"], name: "index_invitees_on_registration_id"

  create_table "registrations", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.boolean  "finalized",          default: false
    t.string   "token"
    t.string   "custom_fields_json"
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id"
  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

end
