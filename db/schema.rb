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

ActiveRecord::Schema.define(version: 20150928111251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "bets", force: :cascade do |t|
    t.string   "title",                  null: false
    t.text     "body"
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.integer  "status",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "feed_activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bet_id"
    t.integer  "stake_id"
    t.string   "type"
    t.jsonb    "details",    default: {}, null: false
    t.datetime "created_at",              null: false
  end

  add_index "feed_activities", ["bet_id"], name: "index_feed_activities_on_bet_id", using: :btree
  add_index "feed_activities", ["stake_id"], name: "index_feed_activities_on_stake_id", using: :btree
  add_index "feed_activities", ["user_id"], name: "index_feed_activities_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
  end

  add_index "notifications", ["activity_id"], name: "index_notifications_on_activity_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "stake_types", force: :cascade do |t|
    t.string   "title",                      null: false
    t.boolean  "numeric",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "stakes", force: :cascade do |t|
    t.text     "objective"
    t.text     "bid",           default: "0",   null: false
    t.integer  "stake_type_id"
    t.integer  "user_id"
    t.integer  "bet_id"
    t.integer  "status",        default: 0,     null: false
    t.boolean  "paid",          default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "stakes", ["bet_id"], name: "index_stakes_on_bet_id", using: :btree
  add_index "stakes", ["stake_type_id"], name: "index_stakes_on_stake_type_id", using: :btree
  add_index "stakes", ["user_id"], name: "index_stakes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                                      null: false
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.jsonb    "friends",                      default: {}, null: false
    t.integer  "role",                         default: 0,  null: false
  end

  add_index "users", ["friends"], name: "index_users_on_friends", using: :gin
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

  add_foreign_key "feed_activities", "bets"
  add_foreign_key "feed_activities", "stakes"
  add_foreign_key "feed_activities", "users"
end
