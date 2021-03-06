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

ActiveRecord::Schema.define(version: 2019_05_22_221621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friended_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friended_user_id"], name: "index_friends_on_friended_user_id"
    t.index ["user_id", "friended_user_id"], name: "index_friends_on_user_id_and_friended_user_id", unique: true
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "headings", force: :cascade do |t|
    t.bigint "user_id"
    t.string "topics"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_headings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.string "slug"
    t.string "head_one", default: [], array: true
    t.string "head_two", default: [], array: true
    t.string "head_three", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_users_on_slug"
  end

  add_foreign_key "friends", "users"
  add_foreign_key "friends", "users", column: "friended_user_id"
end
