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

ActiveRecord::Schema.define(version: 20160209190204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_names", force: :cascade do |t|
    t.string   "eventName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ips", force: :cascade do |t|
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payloads", force: :cascade do |t|
    t.string   "requestedAt"
    t.integer  "respondedIn"
    t.text     "parameters",          default: [],              array: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_environment_id"
    t.integer  "request_type_id"
    t.integer  "ip_id"
    t.integer  "url_id"
    t.integer  "referred_by_id"
    t.integer  "event_name_id"
  end

  create_table "referred_bys", force: :cascade do |t|
    t.string   "referredBy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_types", force: :cascade do |t|
    t.string   "requestType"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "resolutions", force: :cascade do |t|
    t.string   "resolutionWidth"
    t.string   "resolutionHeight"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "urls", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_environments", force: :cascade do |t|
    t.string   "userAgent"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "resolution_id"
  end

end
