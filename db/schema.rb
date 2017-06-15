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

ActiveRecord::Schema.define(version: 20170611071221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "type_activity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "description"
    t.integer  "numberpage"
    t.string   "image"
    t.string   "file"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "categoryname"
    t.string   "description"
    t.integer  "level"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "category_books", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["book_id"], name: "index_category_books_on_book_id", using: :btree
    t.index ["category_id"], name: "index_category_books_on_category_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "comment"
    t.integer  "review_book_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["review_book_id"], name: "index_comments_on_review_book_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "like_activities", force: :cascade do |t|
    t.boolean  "islike"
    t.integer  "user_id"
    t.integer  "user_activity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_activity_id"], name: "index_like_activities_on_user_activity_id", using: :btree
    t.index ["user_id"], name: "index_like_activities_on_user_id", using: :btree
  end

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree
    t.index ["user_id"], name: "index_microposts_on_user_id", using: :btree
  end

  create_table "rating_books", force: :cascade do |t|
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_rating_books_on_book_id", using: :btree
    t.index ["user_id"], name: "index_rating_books_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  end

  create_table "requests", force: :cascade do |t|
    t.string   "title"
    t.string   "contenthtml"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "review_books", force: :cascade do |t|
    t.string   "title"
    t.string   "contenthtml"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["book_id"], name: "index_review_books_on_book_id", using: :btree
    t.index ["user_id"], name: "index_review_books_on_user_id", using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "content"
    t.string   "image"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_statuses_on_user_id", using: :btree
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer  "book_affected"
    t.integer  "user_affected"
    t.integer  "status_id"
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["activity_id"], name: "index_user_activities_on_activity_id", using: :btree
    t.index ["user_id"], name: "index_user_activities_on_user_id", using: :btree
  end

  create_table "user_books", force: :cascade do |t|
    t.integer  "readstatus"
    t.boolean  "isFavorite"
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_user_books_on_book_id", using: :btree
    t.index ["user_id"], name: "index_user_books_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.string   "numberphone"
    t.string   "image"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "category_books", "books"
  add_foreign_key "category_books", "categories"
  add_foreign_key "comments", "review_books"
  add_foreign_key "comments", "users"
  add_foreign_key "like_activities", "user_activities"
  add_foreign_key "like_activities", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "rating_books", "books"
  add_foreign_key "rating_books", "users"
  add_foreign_key "requests", "users"
  add_foreign_key "review_books", "books"
  add_foreign_key "review_books", "users"
  add_foreign_key "statuses", "users"
  add_foreign_key "user_activities", "activities"
  add_foreign_key "user_activities", "users"
  add_foreign_key "user_books", "books"
  add_foreign_key "user_books", "users"
end
