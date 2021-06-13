# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_13_125408) do

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "identification_number"
    t.string "location"
    t.integer "required_employee_count"
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "employees_count"
    t.integer "overall_employees_count"
    t.index ["identification_number"], name: "index_companies_on_identification_number", unique: true
    t.index ["parent_id"], name: "index_companies_on_parent_id"
  end

  create_table "company_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "company_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "company_desc_idx"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "identification_number"
    t.integer "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["identification_number"], name: "index_employees_on_identification_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "companies", "companies", column: "parent_id"
end
