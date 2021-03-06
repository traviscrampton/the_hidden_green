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

ActiveRecord::Schema.define(version: 20170320002025) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "accountable_id"
    t.string   "a_type"
    t.float    "amount"
    t.float    "interest_rate"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "accountable_type"
  end

  create_table "advices", force: :cascade do |t|
    t.integer "adviceable_id"
    t.integer "adviceable_type"
    t.string  "to_type"
    t.integer "to_id"
    t.string  "from_type"
    t.integer "from_id"
    t.float   "amount"
  end

  create_table "assets", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.float   "amount"
  end

  create_table "cash_flows", force: :cascade do |t|
    t.integer "cash_flowable_id"
    t.string  "cash_flowable_type"
    t.float   "amount"
  end

  create_table "debts", force: :cascade do |t|
    t.string   "name"
    t.integer  "debtable_id"
    t.float    "amount"
    t.float    "interest_rate"
    t.float    "minimum_monthly_payment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "debtable_type"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer  "incomeable_id"
    t.string   "source_name"
    t.float    "source_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "incomeable_type"
  end

  create_table "investments", force: :cascade do |t|
    t.string   "name"
    t.integer  "investmentable_id"
    t.float    "amount"
    t.float    "interest_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "investmentable_type"
  end

  create_table "monthly_spendings", force: :cascade do |t|
    t.integer  "monthly_spendable_id"
    t.float    "rent"
    t.float    "food"
    t.float    "phone"
    t.float    "utilities"
    t.float    "everything_else"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "monthly_spendable_type"
  end

  create_table "months", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "sequence_num"
    t.integer "year"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "initial_setup",          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
