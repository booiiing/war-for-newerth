# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090811144844) do

  create_table "alliances", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clans", :force => true do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
    t.binary   "image"
    t.string   "official_url"
    t.string   "sencondary_url"
  end

  create_table "clans_alliances", :id => false, :force => true do |t|
    t.integer "clan_id"
    t.integer "alliance_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "poster_id"
    t.integer  "new_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.datetime "schedule"
    t.integer  "attacker_id"
    t.integer  "defender_id"
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.integer  "poster_id"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "territories", :force => true do |t|
    t.string   "name"
    t.string   "map_name"
    t.string   "shape"
    t.integer  "clan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "position_x"
    t.float    "position_y"
    t.text     "details"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "clan_id"
    t.boolean  "is_admin",                                 :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "users_matches", :force => true do |t|
    t.integer "match_id"
    t.integer "user_id"
  end

end
