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

ActiveRecord::Schema.define(:version => 20121023023822) do

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
  end

  create_table "donations", :force => true do |t|
    t.integer  "contact_id"
    t.string   "date"
    t.string   "amount"
    t.string   "project"
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
    t.string   "day"
    t.string   "month"
    t.string   "year"
    t.string   "occasion"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "contact_id"
  end

end
