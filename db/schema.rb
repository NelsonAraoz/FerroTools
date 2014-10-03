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

ActiveRecord::Schema.define(version: 20140926195718) do

  create_table "categories", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",    default: true
    t.string   "slug"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug"

  create_table "delivers", force: true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delivers", ["location_id"], name: "index_delivers_on_location_id"
  add_index "delivers", ["user_id"], name: "index_delivers_on_user_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "index", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.integer  "number"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "visible",    default: true
  end

  create_table "messenger_locations", force: true do |t|
    t.integer  "user_id"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messenger_locations", ["user_id"], name: "index_messenger_locations_on_user_id"

  create_table "orders", force: true do |t|
    t.integer  "amount"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deliver_id"
    t.integer  "user_id"
  end

  create_table "packages", force: true do |t|
    t.integer  "shipping_id"
    t.integer  "order_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packages", ["order_id"], name: "index_packages_on_order_id"
  add_index "packages", ["shipping_id"], name: "index_packages_on_shipping_id"

  create_table "pictures", force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "pictures", ["product_id"], name: "index_pictures_on_product_id"

  create_table "presentations", force: true do |t|
    t.text     "content",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "brand"
    t.float    "price"
    t.integer  "stock"
    t.integer  "subcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",        default: true
    t.string   "slug"
  end

  add_index "products", ["slug"], name: "index_products_on_slug"
  add_index "products", ["subcategory_id"], name: "index_products_on_subcategory_id"

  create_table "shippings", force: true do |t|
    t.integer  "order_id"
    t.integer  "deliver_id"
    t.string   "status",       default: "pending"
    t.integer  "messenger_id"
    t.date     "delivery"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shippings", ["deliver_id"], name: "index_shippings_on_deliver_id"
  add_index "shippings", ["order_id"], name: "index_shippings_on_order_id"

# Could not dump table "sqlite_stat1" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",     default: true
    t.string   "slug"
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id"
  add_index "subcategories", ["slug"], name: "index_subcategories_on_slug"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "name",                   default: "",        null: false
    t.string   "lastname",               default: "",        null: false
    t.string   "phone",                  default: "",        null: false
    t.string   "address",                default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rol",                    default: "regular"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
