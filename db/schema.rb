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

ActiveRecord::Schema.define(version: 20140604043626) do

  create_table "attendances", force: true do |t|
    t.integer  "lecture_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["lecture_id", "user_id"], name: "index_attendances_on_lecture_id_and_user_id", unique: true
  add_index "attendances", ["lecture_id"], name: "index_attendances_on_lecture_id"
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id"

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "instructor"
    t.string   "notice"
    t.integer  "course_type"
    t.string   "homepage"
    t.integer  "career"
  end

  add_index "courses", ["code"], name: "index_courses_on_code", unique: true
  add_index "courses", ["name"], name: "index_courses_on_name", unique: true

  create_table "lectures", force: true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "schedule_id"
  end

  add_index "lectures", ["schedule_id", "date"], name: "index_lectures_on_schedule_id_and_date", unique: true

  create_table "registrations", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["course_id", "user_id"], name: "index_registrations_on_course_id_and_user_id", unique: true
  add_index "registrations", ["course_id"], name: "index_registrations_on_course_id"
  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id"

  create_table "schedules", force: true do |t|
    t.integer  "day"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
  end

  create_table "users", force: true do |t|
    t.integer  "student_number"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
  end

end
