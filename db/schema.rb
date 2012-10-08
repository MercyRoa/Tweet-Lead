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

ActiveRecord::Schema.define(:version => 20120709043428) do

  create_table "accounts", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "description"
    t.string   "group"
    t.string   "token"
    t.string   "token_secret"
    t.integer  "mentions_count"
    t.integer  "new_mentions_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "last_tweet_id"
    t.string   "last_own_tweet_id"
    t.text     "normal_tweets"
  end

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "warning"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.string   "screen_name"
    t.datetime "created_at"
    t.integer  "followers_count"
    t.integer  "friends_count"
    t.string   "twitter_id"
    t.string   "lang"
    t.string   "location"
    t.string   "profile_image_url"
    t.boolean  "protected"
    t.string   "time_zone"
    t.text     "description"
    t.string   "url"
    t.integer  "utc_offset"
    t.datetime "updated_at"
    t.boolean  "replied"
    t.integer  "account_id"
    t.boolean  "starred"
    t.boolean  "waiting_reply",     :default => false, :null => false
  end

  create_table "responses", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alias"
  end

  create_table "searches", :force => true do |t|
    t.string   "search"
    t.string   "responses"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_tweet_id"
  end

  create_table "searches_logs", :force => true do |t|
    t.integer  "search_id"
    t.integer  "results"
    t.integer  "saved"
    t.integer  "page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches_results", :force => true do |t|
    t.integer  "account_id"
    t.string   "username"
    t.string   "tweet"
    t.string   "reply"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "tweeted_at"
    t.boolean  "sent"
  end

  create_table "sheduled_messages", :force => true do |t|
    t.integer  "account_id"
    t.string   "text"
    t.datetime "created"
    t.datetime "sheduled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
  end

end
