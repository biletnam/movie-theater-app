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

ActiveRecord::Schema.define(version: 20161028033405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auditoria", force: :cascade do |t|
    t.integer  "theater_id"
    t.string   "name"
    t.integer  "seating_capacity"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["theater_id"], name: "index_auditoria_on_theater_id", using: :btree
  end

  create_table "movie_screenings", force: :cascade do |t|
    t.integer  "movie_id"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_screenings_on_movie_id", using: :btree
  end

  create_table "movies", force: :cascade do |t|
    t.integer  "theater_id"
    t.integer  "auditorium_id"
    t.string   "title"
    t.integer  "run_time_minutes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["auditorium_id"], name: "index_movies_on_auditorium_id", using: :btree
    t.index ["theater_id"], name: "index_movies_on_theater_id", using: :btree
  end

  create_table "theaters", force: :cascade do |t|
    t.string   "name"
    t.string   "manager"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
