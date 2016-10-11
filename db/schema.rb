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

ActiveRecord::Schema.define(version: 20161009200851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "identifier"
    t.string   "root_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payloads", force: :cascade do |t|
    t.datetime "requested_at"
    t.integer  "responded_in"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "url_id"
    t.integer  "referral_id"
    t.integer  "request_id"
    t.integer  "event_id"
    t.integer  "user_agent_stat_id"
    t.integer  "resolution_id"
    t.integer  "visitor_id"
    t.integer  "client_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.string   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string   "request_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "resolutions", force: :cascade do |t|
    t.string   "height"
    t.string   "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.string   "url_address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_agent_stats", force: :cascade do |t|
    t.string   "browser"
    t.string   "operating_system"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "visitors", force: :cascade do |t|
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
