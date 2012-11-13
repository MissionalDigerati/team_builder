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

ActiveRecord::Schema.define(:version => 20121113004914) do

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "spouse_name"
    t.string   "email"
    t.string   "spouse_email"
    t.string   "tags"
    t.string   "network"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state_id"
    t.string   "zip"
    t.string   "country_id"
    t.boolean  "receive_newsletter", :default => false
    t.string   "children"
    t.string   "preferred_contact"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "believer"
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
