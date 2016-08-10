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

ActiveRecord::Schema.define(version: 20160810061241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_events_on_name", unique: true, using: :btree
  end

  create_table "results", force: :cascade do |t|
    t.integer  "swimmer_id", null: false
    t.integer  "event_id",   null: false
    t.integer  "year",       null: false
    t.float    "time",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_results_on_event_id", using: :btree
    t.index ["swimmer_id"], name: "index_results_on_swimmer_id", using: :btree
    t.index ["year", "event_id", "swimmer_id"], name: "index_results_on_year_and_event_id_and_swimmer_id", unique: true, using: :btree
  end

  create_table "swimmers", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "team_id"], name: "index_swimmers_on_name_and_team_id", unique: true, using: :btree
    t.index ["team_id"], name: "index_swimmers_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true, using: :btree
  end

  add_foreign_key "results", "events"
  add_foreign_key "results", "swimmers"
  add_foreign_key "swimmers", "teams"
end
