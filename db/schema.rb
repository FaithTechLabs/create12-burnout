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

ActiveRecord::Schema[8.1].define(version: 2025_11_23_015050) do
  create_table "answers", force: :cascade do |t|
    t.integer "answer"
    t.datetime "created_at", null: false
    t.integer "question_id"
    t.string "question_text"
    t.integer "survey_id"
    t.datetime "updated_at", null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.datetime "answered_at"
    t.datetime "created_at", null: false
    t.string "hash_id"
    t.datetime "last_notified_at"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["hash_id"], name: "index_surveys_on_hash_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "accountability_email"
    t.date "birthday"
    t.integer "church_size"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.boolean "has_children"
    t.boolean "is_married"
    t.string "last_name"
    t.datetime "updated_at", null: false
  end
end
