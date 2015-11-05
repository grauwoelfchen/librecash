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

ActiveRecord::Schema.define(version: 20150922174132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trackable_name"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "slug",                    null: false
    t.string   "property"
    t.string   "name",       default: "", null: false
    t.string   "postcode"
    t.string   "country",    default: "", null: false
    t.string   "division",   default: "", null: false
    t.string   "city",       default: "", null: false
    t.string   "address",    default: "", null: false
    t.string   "phone"
    t.string   "email"
    t.string   "memo"
    t.datetime "joined_at"
    t.datetime "left_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "contacts", ["slug"], name: "index_contacts_on_slug", unique: true, using: :btree

  create_table "finance_account_books", force: :cascade do |t|
    t.integer  "report_id",             null: false
    t.string   "name",                  null: false
    t.string   "description"
    t.text     "memo"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "icon",        limit: 8
  end

  add_index "finance_account_books", ["report_id"], name: "index_finance_account_books_on_report_id", using: :btree

  create_table "finance_budgets", force: :cascade do |t|
    t.integer  "report_id",   null: false
    t.string   "description"
    t.text     "memo"
    t.datetime "approved_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "finance_budgets", ["report_id"], name: "index_finance_budgets_on_report_id", using: :btree

  create_table "finance_categories", force: :cascade do |t|
    t.integer  "report_id",               null: false
    t.integer  "type",        default: 0, null: false
    t.string   "name",                    null: false
    t.string   "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "finance_categories", ["report_id"], name: "index_finance_categories_on_report_id", using: :btree
  add_index "finance_categories", ["type"], name: "index_finance_categories_on_type", using: :btree

  create_table "finance_entries", force: :cascade do |t|
    t.integer  "account_book_id",             null: false
    t.integer  "journalizing_id"
    t.integer  "type",            default: 0, null: false
    t.string   "title",                       null: false
    t.integer  "total_amount",    default: 0, null: false
    t.string   "memo"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "finance_entries", ["account_book_id"], name: "index_finance_entries_on_account_book_id", using: :btree
  add_index "finance_entries", ["journalizing_id"], name: "index_finance_entries_on_journalizing_id", using: :btree
  add_index "finance_entries", ["type"], name: "index_finance_entries_on_type", using: :btree

  create_table "finance_journalizings", force: :cascade do |t|
    t.integer  "account_book_id",             null: false
    t.integer  "category_id",                 null: false
    t.integer  "entries_count",   default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "finance_journalizings", ["account_book_id"], name: "index_finance_journalizings_on_account_book_id", using: :btree
  add_index "finance_journalizings", ["category_id"], name: "index_finance_journalizings_on_category_id", using: :btree

  create_table "finance_reports", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.date     "started_at"
    t.date     "finished_at"
    t.integer  "state",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "finance_reports", ["state"], name: "index_finance_reports_on_state", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["contact_id"], name: "index_identities_on_contact_id", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "involvements", force: :cascade do |t|
    t.string   "holder_type"
    t.integer  "holder_id"
    t.string   "matter_type"
    t.integer  "matter_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "involvements", ["holder_type", "holder_id"], name: "index_involvements_on_holder_type_and_holder_id", using: :btree
  add_index "involvements", ["matter_type", "matter_id"], name: "index_involvements_on_matter_type_and_matter_id", using: :btree

  create_table "locker_room_mateships", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "role",       limit: 2, default: 1
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "locker_room_mateships", ["team_id"], name: "index_locker_room_mateships_on_team_id", using: :btree
  add_index "locker_room_mateships", ["user_id"], name: "index_locker_room_mateships_on_user_id", using: :btree

  create_table "locker_room_teams", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.integer  "type_id"
    t.string   "subscription_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "locker_room_teams", ["subdomain"], name: "index_locker_room_teams_on_subdomain", using: :btree
  add_index "locker_room_teams", ["subscription_id"], name: "index_locker_room_teams_on_subscription_id", using: :btree
  add_index "locker_room_teams", ["type_id"], name: "index_locker_room_teams_on_type_id", using: :btree

  create_table "locker_room_types", force: :cascade do |t|
    t.string   "plan_id"
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locker_room_types", ["plan_id"], name: "index_locker_room_types_on_plan_id", using: :btree

  create_table "locker_room_users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email",                                    null: false
    t.string   "password_digest"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "locale",          limit: 5, default: "en", null: false
  end

  add_index "locker_room_users", ["email"], name: "index_locker_room_users_on_email", unique: true, using: :btree
  add_index "locker_room_users", ["username"], name: "index_locker_room_users_on_username", unique: true, using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.text     "content_html"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
