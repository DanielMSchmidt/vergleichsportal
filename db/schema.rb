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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130311103015) do

  create_table "advertisments", :force => true do |t|
    t.string   "img_url"
    t.string   "link_url"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "article_cart_assignments", :force => true do |t|
    t.integer  "article_id"
    t.integer  "cart_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "article_cart_assignments", ["article_id"], :name => "index_article_cart_assignments_on_article_id"
  add_index "article_cart_assignments", ["cart_id"], :name => "index_article_cart_assignments_on_cart_id"

  create_table "article_query_assignments", :force => true do |t|
    t.integer  "article_id"
    t.integer  "search_query_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "article_query_assignments", ["article_id"], :name => "index_article_query_assignments_on_article_id"
  add_index "article_query_assignments", ["search_query_id"], :name => "index_article_query_assignments_on_search_query_id"

  create_table "articles", :force => true do |t|
    t.string   "name"
    t.string   "ean"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "carts", ["user_id"], :name => "index_carts_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "value"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  add_index "comments", ["commentable_type", "commentable_id"], :name => "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "compares", :force => true do |t|
    t.integer  "cart_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "compares", ["cart_id"], :name => "index_compares_on_cart_id"

  create_table "images", :force => true do |t|
    t.string   "url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  add_index "images", ["imageable_type", "imageable_id"], :name => "index_images_on_imageable_type_and_imageable_id"

  create_table "permission_role_assignments", :force => true do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "permission_role_assignments", ["permission_id"], :name => "index_permission_role_assignments_on_permission_id"
  add_index "permission_role_assignments", ["role_id"], :name => "index_permission_role_assignments_on_role_id"

  create_table "permissions", :force => true do |t|
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "prices", :force => true do |t|
    t.decimal  "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "article_id"
    t.integer  "provider_id"
  end

  add_index "prices", ["article_id"], :name => "index_prices_on_article_id"
  add_index "prices", ["provider_id"], :name => "index_prices_on_provider_id"

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "provider_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "rateable_id"
    t.string   "rateable_type"
  end

  add_index "ratings", ["provider_id"], :name => "index_ratings_on_provider_id"
  add_index "ratings", ["rateable_type", "rateable_id"], :name => "index_ratings_on_rateable_type_and_rateable_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "search_queries", :force => true do |t|
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_role_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_role_assignments", ["role_id"], :name => "index_user_role_assignments_on_role_id"
  add_index "user_role_assignments", ["user_id"], :name => "index_user_role_assignments_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                             :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.boolean  "active",                          :default => true
    t.integer  "role_id"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
