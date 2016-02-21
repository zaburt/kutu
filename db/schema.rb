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

ActiveRecord::Schema.define(version: 20160221132644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_categories_articles", id: false, force: :cascade do |t|
    t.integer "article_id"
    t.integer "article_category_id"
  end

  add_index "article_categories_articles", ["article_category_id"], name: "index_article_categories_articles_on_article_category_id", using: :btree
  add_index "article_categories_articles", ["article_id"], name: "index_article_categories_articles_on_article_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.boolean  "publish"
    t.datetime "publish_time"
    t.integer  "game_id"
    t.integer  "picture_id"
    t.text     "content"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "frontpage",     default: true
    t.string   "slug"
  end

  add_index "articles", ["created_by_id"], name: "index_articles_on_created_by_id", using: :btree
  add_index "articles", ["game_id"], name: "index_articles_on_game_id", using: :btree
  add_index "articles", ["picture_id"], name: "index_articles_on_picture_id", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree
  add_index "articles", ["updated_by_id"], name: "index_articles_on_updated_by_id", using: :btree

  create_table "articles_pictures", id: false, force: :cascade do |t|
    t.integer "article_id"
    t.integer "picture_id"
  end

  add_index "articles_pictures", ["article_id"], name: "index_articles_pictures_on_article_id", using: :btree
  add_index "articles_pictures", ["picture_id"], name: "index_articles_pictures_on_picture_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_comments", ["game_id"], name: "index_game_comments_on_game_id", using: :btree
  add_index "game_comments", ["user_id"], name: "index_game_comments_on_user_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.integer  "city_id"
    t.integer  "game_category_id"
    t.integer  "house_id"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.float    "lat"
    t.float    "lng"
    t.text     "story"
    t.text     "game_times"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "slug"
    t.boolean  "active",           default: true
  end

  add_index "games", ["city_id"], name: "index_games_on_city_id", using: :btree
  add_index "games", ["game_category_id"], name: "index_games_on_game_category_id", using: :btree
  add_index "games", ["house_id"], name: "index_games_on_house_id", using: :btree
  add_index "games", ["slug"], name: "index_games_on_slug", unique: true, using: :btree

  create_table "houses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "name"
    t.integer  "game_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "caption"
  end

  add_index "pictures", ["game_id"], name: "index_pictures_on_game_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "display_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "articles", "games"
  add_foreign_key "articles", "pictures"
  add_foreign_key "game_comments", "games"
  add_foreign_key "game_comments", "users"
  add_foreign_key "games", "cities"
  add_foreign_key "games", "game_categories"
  add_foreign_key "games", "houses"
  add_foreign_key "pictures", "games"
end
