# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_25_081016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.bigint "star_id", null: false
    t.string "planet_type"
    t.float "mass"
    t.float "temperature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["star_id"], name: "index_planets_on_star_id"
  end

  create_table "sattelites", force: :cascade do |t|
    t.string "name"
    t.bigint "planet_id", null: false
    t.string "sattelite_type"
    t.float "mass"
    t.float "temperature"
    t.string "form"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_sattelites_on_planet_id"
  end

  create_table "stars", force: :cascade do |t|
    t.string "name"
    t.string "spectral_class"
    t.float "temperature"
    t.float "mass"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "planets", "stars"
  add_foreign_key "sattelites", "planets"
end
