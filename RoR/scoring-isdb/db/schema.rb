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
    t.float    "mark"
    t.integer  "criterion_detail_id"
    t.integer  "assessment_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "assessments", force: :cascade do |t|
    t.float    "mark"
    t.integer  "category_id"
    t.integer  "criterion_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "proposal_id"
    t.integer  "user_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string   "project_action"
    t.string   "cost_type"
    t.float    "cost"
    t.integer  "proposal_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "description"
    t.boolean  "is_active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "criterion_details", force: :cascade do |t|
    t.string   "description"
    t.float    "weight"
    t.boolean  "is_active"
    t.integer  "criterion_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "killing_factor", default: false
  end

  create_table "criterions", force: :cascade do |t|
    t.string   "description"
    t.boolean  "is_active"
    t.integer  "category_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "criterion_type"
  end

  create_table "design_readinesses", force: :cascade do |t|
    t.string   "description"
    t.boolean  "is_active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "development_goals", force: :cascade do |t|
    t.string   "description"
    t.boolean  "is_active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fund_sources", force: :cascade do |t|
    t.string   "description"
    t.boolean  "is_active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "funds", force: :cascade do |t|
    t.integer  "percentage"
    t.integer  "fund_source_id"
    t.integer  "proposal_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "geographic_coverages", force: :cascade do |t|
    t.integer  "beneficiaries_number"
    t.integer  "proposal_id"
    t.integer  "locality_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "classification"
  end

  create_table "grant_sectors", force: :cascade do |t|
    t.integer  "percentage"
    t.integer  "grant_id"
    t.integer  "sector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grants", force: :cascade do |t|
    t.string   "description"
    t.boolean  "is_active"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.float    "budget"
    t.date     "closed_at"
    t.date     "closing_at"
    t.date     "starting_at"
    t.boolean  "is_selection_done"
  end

  create_table "localities", force: :cascade do |t|
    t.string   "locality_code"
    t.string   "locality_name"
    t.float    "population"
    t.integer  "province_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "locality_category", default: "L"
  end

  create_table "number_lists", force: :cascade do |t|
    t.string   "number_label"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "proposal_assessment_summaries", force: :cascade do |t|
    t.boolean  "is_assessed"
    t.float    "total_mark"
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.string   "project_name"
    t.integer  "sector_id"
    t.text     "project_background"
    t.date     "proposal_date"
    t.date     "expected_start_date"
    t.float    "project_period"
    t.text     "project_aim"
    t.text     "target_audience"
    t.integer  "development_goal_id"
    t.text     "project_actions_description"
    t.text     "stakeholders_choosing_method"
    t.text     "stakeholders_description"
    t.text     "project_approach"
    t.text     "technical_methodology"
    t.text     "logical_framework"
    t.text     "supervision"
    t.text     "project_sustainability"
    t.string   "executive_organization"
    t.text     "joint_ventures"
    t.text     "organization_experience"
    t.string   "contact_person"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.text     "positive_impact"
    t.text     "negative_impact"
    t.integer  "short_term_work_opportunities"
    t.integer  "long_term_work_opportunities"
    t.string   "project_schedule"
    t.text     "photos_before_implementation"
    t.text     "project_photos"
    t.integer  "design_readiness_id"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "grant_id"
    t.boolean  "is_submitted"
    t.float    "average_mark"
    t.boolean  "is_selected"
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "poverty_mapping"
  end

  create_table "redactor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], name: "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_redactor_assetable_type"

  create_table "sectors", force: :cascade do |t|
    t.string   "programme"
    t.integer  "percentage"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type"
    t.boolean  "email_confirmed",        default: false
    t.string   "confirm_token"
    t.string   "user_name"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text     "confirmation_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
