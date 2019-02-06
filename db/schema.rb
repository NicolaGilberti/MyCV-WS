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

ActiveRecord::Schema.define(version: 2019_02_06_145211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "curriculums", force: :cascade do |t|
    t.string "reset_password_token"
    t.string "email"
    t.string "password"
    t.string "name"
    t.string "image"
    t.string "location"
    t.string "gender"
    t.string "birthday"
    t.string "hometown"
    t.string "age_range"
    t.string "biography"
    t.string "it_languages"
    t.string "language_spoken"
    t.string "education_from"
    t.string "education_to"
    t.string "education_org_name"
    t.string "education_title"
    t.string "work_from"
    t.string "work_to"
    t.string "work_org_name"
    t.string "work_position"
    t.string "communication_skills"
    t.string "organisational_skills"
    t.string "other_skills"
    t.string "driving_licence"
    t.string "application_type"
    t.string "facebook_auth"
    t.string "github_auth"
    t.string "linkedin_auth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_managers", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "gender"
    t.string "image"
    t.string "email"
    t.string "birthday"
    t.string "languageSpoken"
    t.string "ITlanguages"
    t.text "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.text "image"
    t.text "location"
    t.string "gender"
    t.string "birthday"
    t.string "hometown"
    t.integer "age_range"
    t.string "languageSpoken"
    t.string "ITlanguages"
    t.text "biography"
    t.index ["provider"], name: "index_users_on_provider", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
