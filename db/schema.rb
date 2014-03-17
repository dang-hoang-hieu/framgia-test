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

ActiveRecord::Schema.define(version: 20140317013802) do

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.string   "answer"
    t.boolean  "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "answers_sheet_details", force: true do |t|
    t.integer  "answers_sheet_id", default: 0
    t.integer  "question_id",      default: 0
    t.integer  "user_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers_sheet_details", ["answers_sheet_id"], name: "index_answers_sheet_details_on_answers_sheet_id"

  create_table "answers_sheets", force: true do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.integer  "subject_id"
    t.integer  "status"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers_sheets", ["user_id", "exam_id", "subject_id"], name: "index_answers_sheets_on_user_id_and_exam_id_and_subject_id"
  add_index "answers_sheets", ["user_id", "exam_id"], name: "index_answers_sheets_on_user_id_and_exam_id"
  add_index "answers_sheets", ["user_id", "subject_id"], name: "index_answers_sheets_on_user_id_and_subject_id"
  add_index "answers_sheets", ["user_id"], name: "index_answers_sheets_on_user_id"

  create_table "exams", force: true do |t|
    t.string   "exam"
    t.integer  "total_questions"
    t.integer  "time_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams_subjects", id: false, force: true do |t|
    t.integer  "subject_id"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exams_subjects", ["exam_id", "subject_id"], name: "index_exams_subjects_on_exam_id_and_subject_id"
  add_index "exams_subjects", ["exam_id"], name: "index_exams_subjects_on_exam_id"
  add_index "exams_subjects", ["subject_id"], name: "index_exams_subjects_on_subject_id"

  create_table "levels", force: true do |t|
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "question"
    t.integer  "subject_id"
    t.integer  "level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["level_id"], name: "index_questions_on_level_id"
  add_index "questions", ["subject_id", "level_id"], name: "index_questions_on_subject_id_and_level_id"
  add_index "questions", ["subject_id"], name: "index_questions_on_subject_id"

  create_table "subjects", force: true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_answers", force: true do |t|
    t.integer  "answers_sheet_detail_id"
    t.integer  "user_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",           default: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
