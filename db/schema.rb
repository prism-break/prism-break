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

ActiveRecord::Schema.define(version: 20131001164944) do

  create_table "software_translations", force: true do |t|
    t.integer  "software_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "source_url"
    t.string   "privacy_url"
    t.string   "tos_url"
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
  end

  create_table "tag_translations", force: true do |t|
    t.integer  "tag_id",     null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "tag_translations", ["locale"], name: "index_tag_translations_on_locale", using: :btree
  add_index "tag_translations", ["tag_id"], name: "index_tag_translations_on_tag_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
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
