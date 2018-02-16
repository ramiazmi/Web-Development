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

ActiveRecord::Schema.define(version: 20151112000004) do

  create_table "assessment_criterion_details", force: :cascade do |t|
    t.float    "mark",                limit: 24
    t.integer  "criterion_detail_id", limit: 4
    t.integer  "assessment_id",       limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "assessments", force: :cascade do |t|
    t.float    "mark",         limit: 24
    t.integer  "category_id",  limit: 4
    t.integer  "criterion_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "proposal_id",  limit: 4
    t.integer  "user_id",      limit: 4
  end

  create_table "budgets", force: :cascade do |t|
    t.string   "project_action", limit: 255
    t.string   "cost_type",      limit: 255
    t.float    "cost",           limit: 24
    t.integer  "proposal_id",    limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "description", limit: 255
    t.boolean  "is_active"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "criterion_details", force: :cascade do |t|
    t.string   "description",    limit: 255
    t.float    "weight",         limit: 24
    t.boolean  "is_active"
    t.integer  "criterion_id",   limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "killing_factor",             default: false
  end

  create_table "criterions", force: :cascade do |t|
    t.string   "description",    limit: 255
    t.boolean  "is_active"
    t.integer  "category_id",    limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "criterion_type", limit: 255
  end

  create_table "design_readinesses", force: :cascade do |t|
    t.string   "description", limit: 255
    t.boolean  "is_active"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "development_goals", force: :cascade do |t|
    t.string   "description", limit: 255
    t.boolean  "is_active"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "fund_sources", force: :cascade do |t|
    t.string   "description", limit: 255
    t.boolean  "is_active"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "funds", force: :cascade do |t|
    t.integer  "percentage",     limit: 4
    t.integer  "fund_source_id", limit: 4
    t.integer  "proposal_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "geographic_coverages", force: :cascade do |t|
    t.integer  "beneficiaries_number", limit: 4
    t.integer  "proposal_id",          limit: 4
    t.integer  "locality_id",          limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "classification",       limit: 255
  end

  create_table "grant_sectors", force: :cascade do |t|
    t.integer  "percentage", limit: 4
    t.integer  "grant_id",   limit: 4
    t.integer  "sector_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "grants", force: :cascade do |t|
    t.string   "description",       limit: 255
    t.boolean  "is_active"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.float    "budget",            limit: 24
    t.date     "closed_at"
    t.date     "closing_at"
    t.date     "starting_at"
    t.boolean  "is_selection_done"
  end

  create_table "localities", force: :cascade do |t|
    t.string   "locality_code",     limit: 255
    t.string   "locality_name",     limit: 255
    t.float    "population",        limit: 24
    t.integer  "province_id",       limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "locality_category", limit: 255, default: "L"
  end

  create_table "number_lists", force: :cascade do |t|
    t.string   "number_label", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "proposal_assessment_summaries", force: :cascade do |t|
    t.boolean  "is_assessed"
    t.float    "total_mark",  limit: 24
    t.integer  "proposal_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.string   "project_name",                  limit: 255
    t.integer  "sector_id",                     limit: 4
    t.text     "project_background",            limit: 65535
    t.date     "proposal_date"
    t.date     "expected_start_date"
    t.float    "project_period",                limit: 24
    t.text     "project_aim",                   limit: 65535
    t.text     "target_audience",               limit: 65535
    t.integer  "development_goal_id",           limit: 4
    t.text     "project_actions_description",   limit: 65535
    t.text     "stakeholders_choosing_method",  limit: 65535
    t.text     "stakeholders_description",      limit: 65535
    t.text     "project_approach",              limit: 65535
    t.text     "technical_methodology",         limit: 65535
    t.text     "logical_framework",             limit: 65535
    t.text     "supervision",                   limit: 65535
    t.text     "project_sustainability",        limit: 65535
    t.string   "executive_organization",        limit: 255
    t.text     "joint_ventures",                limit: 65535
    t.text     "organization_experience",       limit: 65535
    t.string   "contact_person",                limit: 255
    t.string   "contact_phone",                 limit: 255
    t.string   "contact_email",                 limit: 255
    t.text     "positive_impact",               limit: 65535
    t.text     "negative_impact",               limit: 65535
    t.integer  "short_term_work_opportunities", limit: 4
    t.integer  "long_term_work_opportunities",  limit: 4
    t.string   "project_schedule",              limit: 255
    t.text     "photos_before_implementation",  limit: 65535
    t.text     "project_photos",                limit: 65535
    t.integer  "design_readiness_id",           limit: 4
    t.integer  "user_id",                       limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "grant_id",                      limit: 4
    t.boolean  "is_submitted"
    t.float    "average_mark",                  limit: 24
    t.boolean  "is_selected"
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "poverty_mapping", limit: 24
  end

  create_table "sectors", force: :cascade do |t|
    t.string   "programme",  limit: 255
    t.integer  "percentage", limit: 4
    t.boolean  "is_active"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type",              limit: 255
    t.boolean  "email_confirmed",                      default: false
    t.string   "confirm_token",          limit: 255
    t.string   "user_name",              limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text     "confirmation_token",     limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
