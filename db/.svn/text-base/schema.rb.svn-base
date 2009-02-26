# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 73) do

  create_table "bull_location_audits", :force => true do |t|
    t.date    "date"
    t.integer "square_number"
    t.integer "count",         :default => 0
  end

  add_index "bull_location_audits", ["date", "square_number"], :name => "index_bull_location_audits_on_date_and_square_number"

  create_table "bull_locations", :force => true do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "playing_square_id", :limit => 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "created_on"
    t.date     "updated_on"
    t.integer  "news_item_id"
  end

  add_index "bull_locations", ["created_on"], :name => "index_bull_locations_on_created_on"
  add_index "bull_locations", ["created_at"], :name => "index_bull_locations_on_created_at"

  create_table "draws", :force => true do |t|
    t.datetime "created_on"
    t.date     "play_date"
    t.boolean  "drawn",          :default => false
    t.integer  "winner_id"
    t.integer  "winning_square"
    t.date     "draw_date"
    t.integer  "runner_up_1_id"
    t.integer  "runner_up_2_id"
  end

  create_table "emails", :force => true do |t|
    t.integer  "entry_id"
    t.string   "receiver_email"
    t.date     "created_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entrant_location_audits", :force => true do |t|
    t.date    "date"
    t.integer "square_number"
    t.integer "count",         :default => 0
  end

  add_index "entrant_location_audits", ["date", "square_number"], :name => "index_entrant_location_audits_on_date_and_square_number"

  create_table "entrants", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "group_id"
    t.integer  "playing_square_id", :limit => 3
    t.boolean  "active",                         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "updated_on"
    t.date     "created_on"
    t.string   "entry_result"
    t.integer  "draw_id"
    t.boolean  "optin"
    t.string   "mobile"
    t.boolean  "feed"
    t.string   "ip_address"
  end

  add_index "entrants", ["draw_id"], :name => "index_entrants_on_draw_id"
  add_index "entrants", ["created_at"], :name => "index_entrants_on_created_at"
  add_index "entrants", ["email", "created_at"], :name => "index_entrants_on_email_and_created_at"

  create_table "groups", :force => true do |t|
    t.integer  "originator_id"
    t.date     "created_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draw_id"
  end

  create_table "media_items", :force => true do |t|
    t.string   "media_type"
    t.string   "uri"
    t.integer  "news_item_id"
    t.date     "created_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.string   "title"
    t.string   "thumbnail"
    t.string   "width"
    t.string   "height"
    t.integer  "playing_square_id"
    t.integer  "parent_id"
  end

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "created_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_type"
    t.boolean  "published",        :default => false
    t.integer  "bull_location_id"
  end

  add_index "news_items", ["created_at"], :name => "index_news_items_on_created_at"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "uids", :force => true do |t|
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entrant_id"
    t.date     "created_on"
  end

  add_index "uids", ["uid"], :name => "index_uids_on_uid"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
