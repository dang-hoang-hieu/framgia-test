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

ActiveRecord::Schema.define(version: 20140325071139) do

  create_table "admins", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.string   "name"
    t.boolean  "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers_sheet_details", force: true do |t|
    t.integer  "answers_sheet_id", default: 0
    t.integer  "question_id",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers_sheet_details", ["answers_sheet_id"], name: "index_answers_sheet_details_on_answers_sheet_id"

  create_table "answers_sheets", force: true do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.integer  "subject_id"
    t.integer  "status"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams_subjects", force: true do |t|
    t.integer  "subject_id"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_questions"
    t.integer  "time_limit"
  end

  create_table "exams_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exams_users", ["exam_id"], name: "index_exams_users_on_exam_id"
  add_index "exams_users", ["user_id", "exam_id"], name: "index_exams_users_on_user_id_and_exam_id"
  add_index "exams_users", ["user_id"], name: "index_exams_users_on_user_id"

  create_table "levels", force: true do |t|
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.integer  "level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_answers", force: true do |t|
    t.integer  "answers_sheet_detail_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
