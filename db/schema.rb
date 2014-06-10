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

ActiveRecord::Schema.define(version: 20140521154357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deployments", force: true do |t|
    t.string   "name", null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deployments", ["name"], unique: true

  create_table "permissions", force: true do |t|
    t.integer   "user_id"
    t.integer   "deployment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "environments", force: true do |t|
    t.string   "name", null: false
    t.text     "public_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deployment_id", null: false
  end

  add_index "environments", ["name","deployment_id"], unique: true

  create_table "secure_contents", force: true do |t|
    t.string   "name", null: false
    t.string   "encrypted_content"
    t.integer  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "environment", null: false
  end

   add_index "secure_contents", ["name","environment"], unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
