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

ActiveRecord::Schema.define(version: 20160211045502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string   "name"
    t.integer  "party"
    t.decimal  "iowa_value"
    t.integer  "total_shares"
    t.integer  "twitter_pos"
    t.integer  "twitter_neg"
    t.integer  "twitter_tot"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "histories", force: :cascade do |t|
    t.string   "candidate"
    t.integer  "units"
    t.decimal  "volume"
    t.decimal  "low"
    t.decimal  "high"
    t.decimal  "average"
    t.decimal  "last"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "candidate_id"
    t.integer  "shares_clinton"
    t.integer  "shares_sanders"
    t.integer  "shares_dem_rof"
    t.integer  "shares_carson"
    t.integer  "shares_cruz"
    t.integer  "shares_rubio"
    t.integer  "shares_trump"
    t.integer  "shares_rep_rof"
    t.decimal  "price"
    t.integer  "buysell"
    t.decimal  "total_value"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "transactions", ["candidate_id"], name: "index_transactions_on_candidate_id", using: :btree
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "fname"
    t.string   "lname"
    t.integer  "party"
    t.decimal  "money"
    t.integer  "shares_clinton"
    t.integer  "shares_sanders"
    t.integer  "shares_dem_rof"
    t.integer  "shares_carson"
    t.integer  "shares_cruz"
    t.integer  "shares_rubio"
    t.integer  "shares_trump"
    t.integer  "shares_rep_rof"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
