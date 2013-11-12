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

ActiveRecord::Schema.define(version: 20131112103600) do

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "sort_order"
    t.text     "description"
    t.integer  "platform_id"
  end

  add_index "categories", ["platform_id"], name: "index_categories_on_platform_id", using: :btree

  create_table "categorizations", force: true do |t|
    t.integer  "category_id"
    t.integer  "software_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree
  add_index "categorizations", ["software_id"], name: "index_categorizations_on_software_id", using: :btree

  create_table "category_hierarchies", force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "category_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "tag_anc_desc_udx", unique: true, using: :btree
  add_index "category_hierarchies", ["descendant_id"], name: "tag_desc_idx", using: :btree

  create_table "category_translations", force: true do |t|
    t.integer  "category_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id", using: :btree
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale", using: :btree

  create_table "license_softwares", force: true do |t|
    t.integer  "license_id"
    t.integer  "software_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "license_softwares", ["license_id"], name: "index_license_softwares_on_license_id", using: :btree
  add_index "license_softwares", ["software_id"], name: "index_license_softwares_on_software_id", using: :btree

  create_table "license_translations", force: true do |t|
    t.integer  "license_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "url"
  end

  add_index "license_translations", ["license_id"], name: "index_license_translations_on_license_id", using: :btree
  add_index "license_translations", ["locale"], name: "index_license_translations_on_locale", using: :btree

  create_table "licenses", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operating_system_softwares", force: true do |t|
    t.integer  "operating_system_id"
    t.integer  "software_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operating_system_softwares", ["operating_system_id"], name: "index_operating_system_softwares_on_operating_system_id", using: :btree
  add_index "operating_system_softwares", ["software_id"], name: "index_operating_system_softwares_on_software_id", using: :btree

  create_table "operating_system_translations", force: true do |t|
    t.integer  "operating_system_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "url"
  end

  add_index "operating_system_translations", ["locale"], name: "index_operating_system_translations_on_locale", using: :btree
  add_index "operating_system_translations", ["operating_system_id"], name: "index_operating_system_translations_on_operating_system_id", using: :btree

  create_table "operating_systems", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "platform_translations", force: true do |t|
    t.integer  "platform_id",   null: false
    t.string   "locale",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "wikipedia_url"
  end

  add_index "platform_translations", ["locale"], name: "index_platform_translations_on_locale", using: :btree
  add_index "platform_translations", ["platform_id"], name: "index_platform_translations_on_platform_id", using: :btree

  create_table "platforms", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "wikipedia_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "protocol_softwares", force: true do |t|
    t.integer  "protocol_id"
    t.integer  "software_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "protocol_softwares", ["protocol_id"], name: "index_protocol_softwares_on_protocol_id", using: :btree
  add_index "protocol_softwares", ["software_id"], name: "index_protocol_softwares_on_software_id", using: :btree

  create_table "protocol_translations", force: true do |t|
    t.integer  "protocol_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "url"
  end

  add_index "protocol_translations", ["locale"], name: "index_protocol_translations_on_locale", using: :btree
  add_index "protocol_translations", ["protocol_id"], name: "index_protocol_translations_on_protocol_id", using: :btree

  create_table "protocols", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "software_translations", force: true do |t|
    t.integer  "software_id",   null: false
    t.string   "locale",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "source_url"
    t.string   "privacy_url"
    t.string   "tos_url"
    t.string   "license_url"
    t.string   "wikipedia_url"
    t.text     "notes"
  end

  add_index "software_translations", ["locale"], name: "index_software_translations_on_locale", using: :btree
  add_index "software_translations", ["software_id"], name: "index_software_translations_on_software_id", using: :btree

  create_table "softwares", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "source_url"
    t.string   "privacy_url"
    t.string   "tos_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "license_url"
    t.string   "wikipedia_url"
    t.text     "notes"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.string   "locale"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
