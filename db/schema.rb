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

ActiveRecord::Schema[7.0].define(version: 2022_10_20_170804) do
  create_table "delivery_times", force: :cascade do |t|
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "deadline_in_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_method_id", null: false
    t.index ["shipping_method_id"], name: "index_delivery_times_on_shipping_method_id"
  end

  create_table "price_by_distances", force: :cascade do |t|
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_method_id", null: false
    t.index ["shipping_method_id"], name: "index_price_by_distances_on_shipping_method_id"
  end

  create_table "price_by_weights", force: :cascade do |t|
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.decimal "price_per_kilometer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_method_id", null: false
    t.index ["shipping_method_id"], name: "index_price_by_weights_on_shipping_method_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.string "initial_full_address"
    t.string "product_code"
    t.string "dimensions"
    t.decimal "weight"
    t.string "recipient_name"
    t.string "identification_document"
    t.string "email"
    t.string "service_order_code"
    t.integer "total_distance"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_phone"
    t.string "full_delivery_address"
    t.decimal "total_delivery_value"
    t.integer "deadline"
    t.integer "shipping_method_id"
    t.datetime "delivery_date"
    t.string "reason_for_delay"
    t.integer "vehicle_id"
    t.datetime "start_date"
    t.index ["shipping_method_id"], name: "index_service_orders_on_shipping_method_id"
    t.index ["vehicle_id"], name: "index_service_orders_on_vehicle_id"
  end

  create_table "shipping_methods", force: :cascade do |t|
    t.string "name"
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.decimal "flat_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.string "brand"
    t.string "model"
    t.string "year_of_manufacture"
    t.integer "maximum_load_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "shipping_method_id", null: false
    t.index ["shipping_method_id"], name: "index_vehicles_on_shipping_method_id"
  end

  add_foreign_key "delivery_times", "shipping_methods"
  add_foreign_key "price_by_distances", "shipping_methods"
  add_foreign_key "price_by_weights", "shipping_methods"
  add_foreign_key "service_orders", "shipping_methods"
  add_foreign_key "service_orders", "vehicles"
  add_foreign_key "vehicles", "shipping_methods"
end
