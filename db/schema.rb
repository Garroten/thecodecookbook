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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140128204015) do

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.datetime "create_at"
    t.datetime "update_at"
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.text     "taged_text"
  end

  create_table "contributions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.datetime "create_at"
  end

  create_table "recipes", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "create_at"
    t.datetime "update_at"
    t.integer  "user_id"
    t.boolean  "is_draft"
    t.text     "marked_text"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                  :limit => 40
    t.string   "name",                   :limit => 100, :default => ""
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",                    :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.integer  "role"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "gener",                                 :default => 0
    t.date     "birth_date"
    t.string   "country",                               :default => ""
    t.string   "city",                                  :default => ""
    t.string   "user_web_site",                         :default => ""
    t.string   "twitter_profile",                       :default => ""
    t.string   "facebook_profile",                      :default => ""
    t.string   "linkedin_profile",                      :default => ""
    t.string   "github_profile",                        :default => ""
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
