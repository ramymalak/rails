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

ActiveRecord::Schema.define(version: 20150510202658) do

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "country_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "event_id",   limit: 4
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "place",       limit: 255
    t.integer  "group_id",    limit: 4
    t.text     "description", limit: 65535
    t.datetime "date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "events", ["group_id"], name: "index_events_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "country_id",  limit: 4
    t.integer  "city_id",     limit: 4
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "groups", ["city_id"], name: "index_groups_on_city_id", using: :btree
  add_index "groups", ["country_id"], name: "index_groups_on_country_id", using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "event_id",            limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "photos", ["event_id"], name: "index_photos_on_event_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",            limit: 255
    t.string   "email",               limit: 255
    t.integer  "age",                 limit: 4
    t.boolean  "gender",              limit: 1
    t.integer  "country_id",          limit: 4
    t.integer  "city_id",             limit: 4
    t.boolean  "isAdmin",             limit: 1
    t.boolean  "isConf",              limit: 1
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_hash",       limit: 255
    t.string   "password_salt",       limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["city_id"], name: "index_users_on_city_id", using: :btree
  add_index "users", ["country_id"], name: "index_users_on_country_id", using: :btree

  add_foreign_key "cities", "countries"
  add_foreign_key "comments", "events"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "groups"
  add_foreign_key "groups", "cities"
  add_foreign_key "groups", "countries"
  add_foreign_key "groups", "users"
  add_foreign_key "photos", "events"
  add_foreign_key "users", "cities"
  add_foreign_key "users", "countries"
end
