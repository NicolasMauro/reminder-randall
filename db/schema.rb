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

ActiveRecord::Schema[8.1].define(version: 2026_08_13_000001) do
  create_table "meetings", force: :cascade do |t|
    t.datetime "acknowledged_at"
    t.datetime "created_at", null: false
    t.boolean "hosting", default: false, null: false
    t.string "join_url"
    t.datetime "notified_at"
    t.string "provider"
    t.datetime "starts_at"
    t.string "title"
    t.string "token"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["token"], name: "index_meetings_on_token", unique: true
    t.index ["user_id", "uid"], name: "index_meetings_on_user_id_and_uid", unique: true
    t.index ["user_id"], name: "index_meetings_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.json "channels", default: ["imessage", "whatsapp", "call", "email"], null: false
    t.boolean "confirm_nudge", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "escalate_after_seconds", default: 90, null: false
    t.integer "grace_minutes", default: 2, null: false
    t.integer "lead_minutes"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "ics_url"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "meetings", "users"
  add_foreign_key "settings", "users"
end
