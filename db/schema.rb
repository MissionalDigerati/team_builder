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

ActiveRecord::Schema.define(version: 20140721233624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archives", force: true do |t|
    t.string   "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "spouse_name"
    t.string   "email"
    t.string   "spouse_email"
    t.string   "network"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state_id"
    t.string   "zip"
    t.string   "country_id"
    t.boolean  "receive_newsletter",     default: false
    t.string   "children"
    t.string   "preferred_contact"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "believer"
    t.integer  "donations_count",        default: 0
    t.boolean  "spouse_believer"
    t.boolean  "presented_vision",       default: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "account_number"
    t.string   "province"
    t.string   "team_status",            default: "pending"
    t.boolean  "sent_letter",            default: false
    t.date     "letter_sent_on"
    t.date     "presented_vision_on"
    t.date     "responded_on"
    t.date     "team_status_updated_on"
  end

  add_index "contacts", ["team_status"], name: "index_contacts_on_team_status", using: :btree

  create_table "countries", force: true do |t|
    t.string   "iso"
    t.string   "name"
    t.string   "printable_name"
    t.string   "iso3"
    t.integer  "numcode"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "donations", force: true do |t|
    t.integer  "contact_id"
    t.string   "project"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.date     "donation_date"
    t.decimal  "amount",        precision: 8, scale: 2
  end

  create_table "notes", force: true do |t|
    t.integer  "contact_id"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "numbers", force: true do |t|
    t.string   "phone_type"
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "contact_id"
    t.string   "note"
  end

  create_table "occasions", force: true do |t|
    t.string   "occasion"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "contact_id"
    t.date     "special_date"
    t.boolean  "incorrect_year"
  end

  create_table "presences", force: true do |t|
    t.integer  "contact_id"
    t.string   "site"
    t.string   "url"
    t.string   "account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: true do |t|
    t.string   "state_long"
    t.string   "state_short"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "support_states", force: true do |t|
    t.integer  "contact_id"
    t.boolean  "initial",           default: true
    t.boolean  "letter_sent",       default: false
    t.date     "letter_sent_on"
    t.boolean  "contacting",        default: false
    t.boolean  "seen_presentation", default: false
    t.date     "presented_on"
    t.boolean  "following_up",      default: false
    t.date     "responding_on"
    t.boolean  "one_time_gift",     default: false
    t.boolean  "monthly_gift",      default: false
    t.boolean  "not_giving",        default: false
    t.boolean  "no_response",       default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "progress_percent"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: true do |t|
    t.integer  "contact_id"
    t.boolean  "completed",  default: false
    t.string   "task"
    t.string   "category"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.date     "due_date"
  end

end
