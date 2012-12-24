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

ActiveRecord::Schema.define(:version => 20121224053610) do

  create_table "admin_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.string   "type_name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "created_by"
    t.datetime "deleted_at"
    t.boolean  "private",       :default => true, :null => false
    t.integer  "face_photo_id"
    t.integer  "views_count",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.text     "body"
    t.integer  "created_by"
    t.integer  "question_id"
    t.integer  "expert_count"
    t.text     "expert_ids"
    t.datetime "deleted_at"
    t.boolean  "is_anonymous"
    t.integer  "thanks_count"
    t.text     "thanks_ids"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_expert"
    t.integer  "deleted_by"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "cms_role_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "assignments", ["user_id", "cms_role_id"], :name => "index_assignments_on_user_id_and_cms_role_id"

  create_table "attachments", :force => true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.string   "attachment_file_size"
    t.string   "purpose"
    t.text     "note"
    t.integer  "deleted_by_id"
    t.datetime "deleted_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "access_token"
    t.string   "access_token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sync_setting"
  end

  create_table "babies", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.datetime "birthday"
    t.integer  "profile_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bbt_comments", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "body"
    t.integer  "model_object_id"
    t.integer  "object_target_id"
    t.text     "excerpt"
    t.integer  "created_by"
    t.boolean  "state"
    t.integer  "confirmed_by"
    t.datetime "confirmed_at"
    t.string   "feedback_ip"
    t.boolean  "is_anonymous"
    t.datetime "deleted_at"
    t.text     "like_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_bases", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.text     "description", :limit => 16777215
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "cms_roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cms_templates", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "cr_permits", :force => true do |t|
    t.integer  "cms_role_id"
    t.integer  "permit_id"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cu_permits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "permit_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",                      :null => false
    t.string   "followable_type",                    :null => false
    t.integer  "follower_id",                        :null => false
    t.string   "follower_type",                      :null => false
    t.boolean  "blocked",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "goods", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "avatar_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kindeditor_assets", :force => true do |t|
    t.string   "asset"
    t.integer  "file_size"
    t.string   "file_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knowledges", :force => true do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.text     "body"
    t.text     "timeline_ids"
    t.integer  "created_by"
    t.string   "created_name",      :limit => 100,                :null => false
    t.integer  "updated_by"
    t.datetime "deleted_at"
    t.integer  "deleted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thanks_count",                     :default => 0, :null => false
    t.integer  "forwarding_count",                 :default => 0, :null => false
    t.integer  "comments_count",                   :default => 0, :null => false
    t.integer  "views_count",                      :default => 0, :null => false
    t.string   "source_info",       :limit => 100
    t.text     "auto_tags"
    t.string   "face_file_name"
    t.string   "face_content_type"
    t.string   "face_file_size"
    t.text     "terms"
  end

  create_table "levels", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "need_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_boxes", :force => true do |t|
    t.integer  "created_by"
    t.integer  "send_to"
    t.text     "content"
    t.integer  "message_template_id"
    t.boolean  "is_read"
    t.integer  "message_type_id"
    t.integer  "model_object_id"
    t.integer  "object_target_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",             :default => false
    t.boolean  "copies",              :default => false
    t.boolean  "opened",              :default => false
    t.integer  "user_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "ancestry"
    t.integer  "subject_id"
    t.string   "subject"
  end

  add_index "message_boxes", ["user_id", "subject_id", "ancestry"], :name => "message_boxes_idx"

  create_table "message_templates", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "message_type_id"
    t.integer  "model_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "subject_id"
    t.string   "subject"
    t.text     "content"
    t.boolean  "opened",       :default => false
    t.boolean  "deleted",      :default => false
    t.boolean  "copies",       :default => false
    t.string   "ancestry"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "messages", ["user_id", "subject_id", "ancestry"], :name => "messages_idx"

  create_table "model_objects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.text     "body"
    t.integer  "draft"
    t.integer  "private"
    t.text     "tags",              :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "views_count",                           :default => 0
    t.integer  "thanks_count"
    t.integer  "top"
    t.string   "face_file_name"
    t.string   "face_content_type"
    t.integer  "face_file_size"
    t.datetime "face_updated_at"
    t.text     "terms"
  end

  create_table "permits", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "album_id"
    t.string   "description"
    t.integer  "created_by"
    t.datetime "deleted_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thanks_count"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.text     "label"
    t.string   "nickname"
    t.string   "real_name"
    t.boolean  "gender"
    t.date     "birthday"
    t.string   "city"
    t.date     "expected_date"
    t.string   "weibo"
    t.string   "hobby"
    t.string   "face_file_name"
    t.string   "face_content_type"
    t.string   "face_file_size"
    t.integer  "invite_user_id"
    t.integer  "level_id"
    t.integer  "user_points"
    t.text     "expert_field"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "agerange"
    t.integer  "pregnancy_status"
    t.integer  "pregnancy_timeline"
    t.string   "oauth_face_image_url"
    t.datetime "face_updated_at"
    t.string   "degree"
    t.string   "phone"
    t.string   "qq"
    t.string   "msn"
    t.string   "telephone"
    t.string   "job"
    t.text     "resume"
    t.text     "terms"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "body"
    t.text     "focus_by"
    t.integer  "created_by"
    t.integer  "views_count"
    t.datetime "last_answer_time"
    t.integer  "best_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "answers_count"
    t.integer  "experts_count"
    t.integer  "designated_answerer"
    t.text     "auto_tags"
    t.integer  "knowledge_id"
    t.boolean  "is_anonymous"
    t.boolean  "deleted"
    t.integer  "deleted_by"
    t.datetime "deleted_at"
    t.integer  "score"
    t.integer  "thanks_count"
    t.text     "terms"
  end

  create_table "quizzes", :force => true do |t|
    t.string   "title"
    t.date     "end_date"
    t.boolean  "answer"
    t.integer  "knowledge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cnt_true"
    t.integer  "cnt_false"
    t.boolean  "deleted"
  end

  create_table "r_objects", :force => true do |t|
    t.integer  "object_id"
    t.integer  "object_category"
    t.integer  "recommend_id"
    t.integer  "recommend_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "r_tag_objects", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "object_id"
    t.integer  "object_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "r_user_knowledges", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "knowledge_id"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "r_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "r_users_objects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "object_id"
    t.integer  "object_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "var",                            :null => false
    t.text     "value",      :limit => 16777215
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "show_tags", :force => true do |t|
    t.string   "name"
    t.integer  "display_order"
    t.string   "display_color"
    t.boolean  "is_customer",   :default => false
    t.integer  "created_by"
    t.boolean  "state",         :default => true
    t.datetime "confirmed_at"
    t.integer  "confirmed_by"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

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
    t.string  "name"
    t.integer "knowledges_count"
    t.integer "questions_count"
    t.integer "profiles_count"
  end

  create_table "template_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", :force => true do |t|
    t.text     "body"
    t.integer  "template_type_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "deleted_at"
    t.integer  "deleted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timelines", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "depth"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "reuse_token"
    t.string   "username"
    t.string   "authentication_token"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
