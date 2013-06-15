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

ActiveRecord::Schema.define(:version => 20130615232741) do

  create_table "actions", :force => true do |t|
    t.string   "action_type"
    t.integer  "threshold"
    t.string   "data"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "actions", ["user_id"], :name => "index_actions_on_user_id"

  create_table "alerts", :force => true do |t|
    t.string   "action_type"
    t.integer  "threshold"
    t.string   "data"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "alerts", ["user_id"], :name => "index_alerts_on_user_id"

  create_table "tweets", :force => true do |t|
    t.integer  "user_id"
    t.string   "tweet_id"
    t.text     "body"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "tweet_type"
  end

  add_index "tweets", ["user_id"], :name => "index_tweets_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "Twitter_Handle"
  end

end
