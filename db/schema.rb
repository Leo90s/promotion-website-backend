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

ActiveRecord::Schema.define(version: 2019_04_16_095901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "address"
    t.string "contact"
    t.datetime "created_at", null: false
    t.string "introduction"
    t.string "name"
    t.datetime "updated_at", null: false
    t.string "url"
  end

  create_table "company_pictures", force: :cascade do |t|
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.bigint "picture_id"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_pictures_on_company_id"
    t.index ["picture_id"], name: "index_company_pictures_on_picture_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.string "file"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_pictures_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "account"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end
end
