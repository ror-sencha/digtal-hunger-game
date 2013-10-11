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

ActiveRecord::Schema.define(version: 20131011173813) do

  create_table "activity_feeds", force: true do |t|
    t.text     "message"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "is_like",             default: false
    t.integer  "liked_by"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentication_tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "auth_token"
    t.date     "last_used_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_options", force: true do |t|
    t.string   "option"
    t.integer  "mini_challenge_id"
    t.boolean  "answer",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", force: true do |t|
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_published", default: false
    t.integer  "likes",        default: 0
  end

  create_table "comments", force: true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "description"
    t.integer  "challenge_id"
    t.integer  "user_id"
    t.string   "challenge_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_challenge_id"
  end

  create_table "document_challenges", force: true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_blasts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_templates", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_comments", force: true do |t|
    t.text     "message"
    t.integer  "activity_feed_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "judge_points", force: true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mini_challenge_answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "mini_challenge_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mini_challenges", force: true do |t|
    t.string   "title"
    t.string   "question"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "minichallenge_points", force: true do |t|
    t.integer  "mini_challenge_id"
    t.integer  "user_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_challenges", force: true do |t|
    t.integer  "challenge_id"
    t.integer  "user_id"
    t.date     "date_submitted"
    t.string   "youtube_link"
    t.boolean  "make_public",         default: false
    t.boolean  "judge_can_view",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "description"
  end

  create_table "recent_activities", force: true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.string   "type"
    t.text     "message"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rc_type"
  end

  create_table "skills", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_media_points", force: true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.integer  "points",       default: 0
    t.string   "media_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_endorses", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.integer  "endorse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skills", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",          null: false
    t.string   "encrypted_password",     default: "",          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "sex"
    t.string   "title"
    t.string   "company"
    t.string   "bio"
    t.string   "status",                 default: "spectator"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "last_name"
    t.integer  "points"
    t.string   "country"
    t.string   "company_title"
    t.integer  "md_id"
    t.boolean  "accept_as_player",       default: false
    t.boolean  "reject_as_player",       default: false
    t.text     "message_for_rejection"
    t.integer  "support"
    t.integer  "mini_points",            default: 0
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "video_challenges", force: true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "video_pages", force: true do |t|
    t.string   "video_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
