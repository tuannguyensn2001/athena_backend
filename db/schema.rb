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

ActiveRecord::Schema[7.0].define(version: 2023_09_27_094418) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "members", force: :cascade do |t|
    t.integer "user_id"
    t.integer "workshop_id"
    t.string "role"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "username"
    t.string "school"
    t.integer "birthday"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "phone"
    t.string "password"
    t.string "email"
    t.integer "email_verified_at"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workshops", force: :cascade do |t|
    t.string "name"
    t.string "thumbnail"
    t.string "private_code"
    t.string "code"
    t.boolean "approve_student"
    t.boolean "prevent_student_leave"
    t.boolean "approve_show_score"
    t.boolean "disable_newsfeed"
    t.boolean "limit_policy_teacher"
    t.boolean "is_show"
    t.string "subject"
    t.string "grade"
    t.boolean "is_lock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
