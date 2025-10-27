# frozen_string_literal: true

ActiveRecord::Schema[7.1].define(version: 20240101000003) do
  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.text "summary", null: false
    t.text "content", null: false
    t.datetime "published_at", null: false
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investors", force: :cascade do |t|
    t.string "firm_name", null: false
    t.text "values", null: false
    t.text "thesis", null: false
    t.text "portfolio_highlights"
    t.text "request_for_startups", null: false
    t.string "website"
    t.string "contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opportunities", force: :cascade do |t|
    t.integer "opportunity_type", null: false
    t.string "title", null: false
    t.string "full_name", null: false
    t.string "organization", null: false
    t.text "description", null: false
    t.string "link"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end
end
