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

ActiveRecord::Schema.define(version: 20150523101136) do

  create_table "albums", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "name",          limit: 120, null: false
    t.date     "creation_date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "cover"
  end

  add_index "albums", ["owner_id"], name: "index_albums_on_owner_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "photo_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["photo_id"], name: "index_comments_on_photo_id"

  create_table "owners", force: :cascade do |t|
    t.string   "login",               limit: 24, null: false
    t.string   "password_digest"
    t.string   "residence"
    t.string   "sex"
    t.date     "birthday"
    t.string   "mail",                           null: false
    t.string   "page_link"
    t.integer  "role"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "title",              limit: 40
    t.date     "creation_date"
    t.string   "description",        limit: 200
    t.integer  "num_of_assessments"
    t.integer  "sum_of_assessments"
    t.float    "average_rating"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "position"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id"

  create_table "user_usergroups", force: :cascade do |t|
    t.integer  "usergroup_id"
    t.integer  "user_id"
    t.date     "begin_date"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "user_usergroups", ["user_id"], name: "index_user_usergroups_on_user_id"
  add_index "user_usergroups", ["usergroup_id"], name: "index_user_usergroups_on_usergroup_id"

  create_table "usergroups", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "usergroups", ["owner_id"], name: "index_usergroups_on_owner_id"

end
