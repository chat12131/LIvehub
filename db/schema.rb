# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_30_150817) do

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.string "nickname"
    t.string "image"
    t.string "genre"
    t.integer "user_id"
    t.text "memo"
    t.boolean "nickname_mode", default: false
    t.boolean "favorited", default: false
    t.date "founding_date"
    t.date "first_show_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_artists_on_name"
    t.index ["nickname"], name: "index_artists_on_nickname"
    t.index ["user_id"], name: "index_artists_on_user_id"
  end

  create_table "live_records", force: :cascade do |t|
    t.string "name"
    t.integer "artist_id"
    t.date "date"
    t.time "start_time"
    t.integer "venue_id", null: false
    t.integer "ticket_price"
    t.integer "drink_price"
    t.string "timetable"
    t.string "announcement_image"
    t.text "memo"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_live_records_on_artist_id"
    t.index ["user_id"], name: "index_live_records_on_user_id"
    t.index ["venue_id"], name: "index_live_records_on_venue_id"
  end

  create_table "live_schedules", force: :cascade do |t|
    t.string "name"
    t.integer "artist_id"
    t.date "date"
    t.time "open_time"
    t.time "start_time"
    t.integer "venue_id", null: false
    t.integer "ticket_status"
    t.integer "ticket_price"
    t.integer "drink_price"
    t.datetime "ticket_sale_date"
    t.string "timetable"
    t.string "announcement_image"
    t.text "memo"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_live_schedules_on_artist_id"
    t.index ["user_id"], name: "index_live_schedules_on_user_id"
    t.index ["venue_id"], name: "index_live_schedules_on_venue_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.integer "artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_members_on_artist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "google_place_id"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.string "area"
    t.index ["user_id"], name: "index_venues_on_user_id"
  end

  add_foreign_key "artists", "users"
  add_foreign_key "live_records", "artists"
  add_foreign_key "live_records", "users"
  add_foreign_key "live_records", "venues"
  add_foreign_key "live_schedules", "artists"
  add_foreign_key "live_schedules", "users"
  add_foreign_key "live_schedules", "venues"
  add_foreign_key "members", "artists"
  add_foreign_key "venues", "users"
end
