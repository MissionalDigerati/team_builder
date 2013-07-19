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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130719213056) do

  create_table "archives", :force => true do |t|
    t.string   "filename"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contacts", :force => true do |t|
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
    t.boolean  "receive_newsletter",  :default => false
    t.string   "children"
    t.string   "preferred_contact"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "believer"
    t.integer  "donations_count",     :default => 0
    t.boolean  "spouse_believer"
    t.boolean  "presented_vision",    :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "account_number"
  end

  create_table "countries", :force => true do |t|
    t.string   "iso"
    t.string   "name"
    t.string   "printable_name"
    t.string   "iso3"
    t.integer  "numcode"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "donations", :force => true do |t|
    t.integer  "contact_id"
    t.float    "amount",        :limit => 255
    t.string   "project"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.date     "donation_date"
  end

  create_table "notes", :force => true do |t|
    t.integer  "contact_id"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "numbers", :force => true do |t|
    t.string   "phone_type"
    t.string   "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "contact_id"
    t.string   "note"
  end

  create_table "occasions", :force => true do |t|
    t.string   "occasion"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "contact_id"
    t.date     "special_date"
    t.boolean  "incorrect_year"
  end

  create_table "presences", :force => true do |t|
    t.integer  "contact_id"
    t.string   "site"
    t.string   "url"
    t.string   "account"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "state_long"
    t.string   "state_short"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "support_states", :force => true do |t|
    t.integer  "contact_id"
    t.boolean  "initial",           :default => true
    t.boolean  "letter_sent",       :default => false
    t.date     "letter_sent_on"
    t.boolean  "contacting",        :default => false
    t.boolean  "seen_presentation", :default => false
    t.date     "presented_on"
    t.boolean  "following_up",      :default => false
    t.date     "responding_on"
    t.boolean  "one_time_gift",     :default => false
    t.boolean  "monthly_gift",      :default => false
    t.boolean  "not_giving",        :default => false
    t.boolean  "no_response",       :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "progress_percent"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "contact_id"
    t.boolean  "completed",                 :default => false
    t.string   "task"
    t.date     "due_date",   :limit => 255
    t.string   "category"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

end
