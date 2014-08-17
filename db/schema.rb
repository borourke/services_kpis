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

ActiveRecord::Schema.define(version: 20140817042913) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "project_name"
    t.string   "team"
    t.date     "delivery_date"
    t.integer  "hours"
    t.decimal  "spoilage"
    t.string   "project_number"
    t.integer  "sla_accuracy"
    t.integer  "accuracy"
    t.integer  "user_id"
    t.integer  "report_card"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "report_cards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "report_card"
    t.integer  "project_id"
    t.integer  "client_id"
    t.string   "type"
    t.integer  "user_id"
  end

  create_table "surveys", force: true do |t|
    t.string   "prescreen"
    t.string   "survey"
    t.string   "job_owner"
    t.string   "project_number"
    t.integer  "respondants"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "payment_cents"
    t.integer  "user_id"
    t.integer  "job_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "team"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
