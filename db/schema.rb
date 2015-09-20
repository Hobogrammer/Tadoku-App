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

ActiveRecord::Schema.define(version: 20130613030900) do

  create_table "bots", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", force: true do |t|
    t.integer  "user_id"
    t.integer  "round_id"
    t.decimal  "book",       default: 0.0
    t.decimal  "manga",      default: 0.0
    t.decimal  "net",        default: 0.0
    t.decimal  "fgame",      default: 0.0
    t.decimal  "game",       default: 0.0
    t.decimal  "lyric",      default: 0.0
    t.decimal  "subs",       default: 0.0
    t.decimal  "news",       default: 0.0
    t.decimal  "sent",       default: 0.0
    t.decimal  "nico",       default: 0.0
    t.decimal  "pcount",     default: 0.0
    t.integer  "goal"
    t.boolean  "gmet",       default: false
    t.string   "lang1",      default: ""
    t.string   "lang2",      default: ""
    t.string   "lang3",      default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tier",       default: "0"
  end

  create_table "tiers", force: true do |t|
    t.string  "uid"
    t.string  "prev_tier"
    t.string  "curr_tier"
    t.boolean "pending"
  end

  create_table "updates", force: true do |t|
    t.integer  "user_id"
    t.integer  "round_id"
    t.decimal  "newread",                 default: 0.0
    t.string   "medium"
    t.string   "lang"
    t.decimal  "recpage",                 default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repeat",                  default: 0
    t.boolean  "dr",                      default: false
    t.decimal  "raw",                     default: 0.0
    t.datetime "created_at_in_user_time"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.boolean  "admin",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.string   "avatar",     default: ""
  end

end
