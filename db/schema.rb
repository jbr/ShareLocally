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

ActiveRecord::Schema.define(:version => 20090823185622) do

  create_table "items", :force => true do |t|
    t.string   "title"
    t.string   "description", :limit => 2048
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "available",                   :default => true, :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "to_user_id"
    t.integer  "from_user_id"
    t.text     "body"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean  "notification_pending", :default => true, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                          :limit => 40
    t.string   "name",                           :limit => 100, :default => ""
    t.string   "email",                          :limit => 100
    t.string   "crypted_password",               :limit => 40
    t.string   "salt",                           :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",                 :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",                :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                         :default => "passive"
    t.datetime "deleted_at"
    t.string   "url_param"
    t.string   "full_name"
    t.string   "phone"
    t.float    "lat"
    t.float    "lng"
    t.string   "address",                        :limit => 512
    t.boolean  "receives_request_notifications",                :default => true,      :null => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
