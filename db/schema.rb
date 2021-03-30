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

ActiveRecord::Schema.define(version: 20210319120523) do

  create_table "ecg_data", force: :cascade do |t|
    t.integer "hr"
    t.integer "hrv"
    t.integer "pnn50"
    t.integer "nn50"
    t.integer "lfhf"
    t.boolean "anomaly"
    t.integer "ecg_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ecg_id"], name: "index_ecg_data_on_ecg_id"
  end

  create_table "ecg_raws", force: :cascade do |t|
    t.integer "ecg_id"
    t.string "classification"
    t.string "symptoms"
    t.string "device"
    t.string "sample_rate"
    t.string "unit"
    t.string "values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ecg_id"], name: "index_ecg_raws_on_ecg_id"
  end

  create_table "ecgs", force: :cascade do |t|
    t.integer "patient_id"
    t.datetime "recorded_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_ecgs_on_patient_id"
  end

  create_table "emotes", force: :cascade do |t|
    t.datetime "time"
    t.string "value"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_emotes_on_patient_id"
  end

  create_table "medications", force: :cascade do |t|
    t.datetime "time"
    t.string "name"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_medications_on_patient_id"
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "time"
    t.string "text"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_notes_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.integer "height"
    t.integer "weight"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "therapist_id"
    t.string "sex"
    t.index ["therapist_id"], name: "index_patients_on_therapist_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "token"
    t.integer "therapist_id"
    t.integer "patient_id"
    t.index ["patient_id"], name: "index_sessions_on_patient_id"
    t.index ["therapist_id"], name: "index_sessions_on_therapist_id"
  end

  create_table "therapists", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "prefix"
    t.string "profession"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
  end

  create_table "words", force: :cascade do |t|
    t.datetime "time"
    t.string "value"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "score"
    t.index ["patient_id"], name: "index_words_on_patient_id"
  end

end
