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

ActiveRecord::Schema[7.2].define(version: 2026_10_15_000005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_classrooms_on_teacher_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id", "student_id"], name: "index_enrollments_on_classroom_id_and_student_id", unique: true
    t.index ["classroom_id"], name: "index_enrollments_on_classroom_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "skill_id", null: false
    t.string "prompt", null: false
    t.string "correct_answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_questions_on_skill_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "role", null: false
    t.string "time_zone", default: "UTC", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "classrooms", "users", column: "teacher_id"
  add_foreign_key "enrollments", "classrooms"
  add_foreign_key "enrollments", "users", column: "student_id"
  add_foreign_key "questions", "skills"
end
