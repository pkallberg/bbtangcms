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

ActiveRecord::Schema.define(:version => 20120618054823) do

  create_table "admin_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.string   "type_name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "body"
    t.integer  "position"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "deleted_at"
    t.string   "width"
    t.string   "height"
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
    t.integer  "opposition_count"
    t.text     "opposition_ids"
    t.integer  "approval_count"
    t.text     "approval_ids"
    t.integer  "expert_count"
    t.text     "expert_ids"
    t.datetime "deleted_at"
    t.boolean  "is_anonymous"
    t.integer  "no_help_count"
    t.text     "no_help_ids"
    t.integer  "thanks_count"
    t.text     "thanks_ids"
    t.boolean  "delta",            :default => true, :null => false
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_expert"
  end

  create_table "astests", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "access_token"
    t.string   "access_token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_bases", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "cms_module_configs", :force => true do |t|
    t.integer  "cms_module_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_module_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_modules", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "cms_module_type_id"
    t.string   "file"
    t.text     "config"
    t.string   "admin_form"
    t.string   "face_file_name"
    t.string   "face_content_type"
    t.string   "face_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_pages", :force => true do |t|
    t.string   "description"
    t.integer  "cms_template_id"
    t.text     "module_list"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_templates", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
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

  create_table "configurations", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expert_fields", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ezines", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "body"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "periodical"
    t.boolean  "is_draft"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_file_size"
    t.string   "thumbnail_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "model_object_id"
    t.integer  "object_target_id"
    t.string   "object_uri"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "focus_on_groups", :force => true do |t|
    t.string   "name"
    t.integer  "created_by"
    t.text     "members",    :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "group_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "body"
    t.integer  "users_count"
    t.integer  "create_by"
    t.integer  "updated_by"
    t.integer  "position"
    t.string   "thumbnail_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "body"
    t.integer  "position"
    t.string   "thumbnail_path"
    t.boolean  "state"
    t.boolean  "is_basic"
    t.integer  "users_count"
    t.integer  "topics_count"
    t.text     "tags"
    t.text     "focus_user_by"
    t.datetime "deleted_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "deleted_by"
    t.integer  "group_category_id"
    t.boolean  "delta",             :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kindeditor_assets", :force => true do |t|
    t.string   "asset"
    t.integer  "file_size"
    t.string   "file_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knowledgebase_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "body"
    t.string   "thumbnail_path"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knowledgebase_nodes", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.text     "description"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knowledges", :force => true do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.text     "body"
    t.text     "timeline_ids"
    t.integer  "knowledgebase_category_id"
    t.integer  "created_by"
    t.string   "created_name",              :limit => 100,                   :null => false
    t.integer  "updated_by"
    t.datetime "deleted_at"
    t.integer  "deleted_by"
    t.boolean  "delta",                                    :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thanks_count",                             :default => 0,    :null => false
    t.integer  "forwarding_count",                         :default => 0,    :null => false
    t.integer  "comments_count",                           :default => 0,    :null => false
    t.integer  "views_count",                              :default => 0,    :null => false
    t.string   "source_info",               :limit => 100
    t.text     "auto_tags"
  end

  create_table "levels", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "need_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_logs", :force => true do |t|
    t.datetime "login_time"
    t.integer  "user_id"
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
  end

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

  create_table "model_objects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mom_shows", :force => true do |t|
    t.string   "title"
    t.text     "body",             :limit => 16777215
    t.text     "content",          :limit => 16777215
    t.string   "images"
    t.text     "like_by",          :limit => 16777215
    t.integer  "like_by_count",                        :default => 0
    t.integer  "excerpt_count",                        :default => 0
    t.text     "excerpt_to",       :limit => 16777215
    t.text     "excerpt_from",     :limit => 16777215
    t.text     "tags",             :limit => 16777215
    t.integer  "show_category_id"
    t.datetime "deleted_at"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.text     "body"
    t.integer  "draft"
    t.integer  "private"
    t.text     "tags",        :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
    t.integer  "views_count",                     :default => 0
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
  end

  create_table "preferences", :force => true do |t|
    t.string   "name"
    t.integer  "owner_id",                 :null => false
    t.string   "owner_type", :limit => 50, :null => false
    t.integer  "group_id"
    t.string   "group_type", :limit => 50
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "label"
    t.string   "nickname"
    t.string   "real_name"
    t.boolean  "gender"
    t.date     "birthday"
    t.string   "province"
    t.string   "city"
    t.string   "town"
    t.date     "expected_date"
    t.date     "child_birthday"
    t.integer  "child_gender"
    t.string   "profession"
    t.string   "weibo"
    t.string   "hobby"
    t.text     "modules"
    t.integer  "posts_count"
    t.string   "face_file_name"
    t.string   "face_content_type"
    t.string   "face_file_size"
    t.boolean  "notify_via_email"
    t.boolean  "notify_on_new_articles"
    t.boolean  "notify_on_comments"
    t.integer  "invite_user_id"
    t.text     "blacklist"
    t.text     "recently_visits"
    t.text     "like_by_count"
    t.integer  "level_id"
    t.integer  "user_points"
    t.text     "expert_field"
    t.string   "subject"
    t.text     "focus_tags_on"
    t.integer  "user_data_statistic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",                  :default => true, :null => false
    t.integer  "agerange"
    t.integer  "pregnancy_status"
    t.integer  "pregnancy_timeline"
    t.boolean  "baby_gender"
    t.string   "oauth_face_image_url"
    t.datetime "face_updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "body"
    t.text     "focus_by"
    t.integer  "created_by"
    t.integer  "views_count"
    t.boolean  "delta",               :default => true, :null => false
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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "setting_subjects", :force => true do |t|
    t.string   "name"
    t.integer  "setting_type_id"
    t.string   "controller_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "setting_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "show_categories", :force => true do |t|
    t.string   "name"
    t.integer  "display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_comments", :force => true do |t|
    t.string   "title"
    t.text     "content",      :limit => 16777215
    t.text     "body",         :limit => 16777215
    t.integer  "created_by"
    t.boolean  "state"
    t.integer  "confirmed_by"
    t.datetime "confirmed_at"
    t.integer  "mom_show_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "subjects", :force => true do |t|
    t.string  "title"
    t.string  "title2"
    t.text    "content"
    t.text    "body"
    t.text    "summary"
    t.integer "category"
    t.integer "sort_index"
    t.text    "releated_ids"
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

  create_table "tags_bak", :force => true do |t|
    t.string   "name"
    t.text     "follower_ids"
    t.text     "knowledge_ids"
    t.text     "summary"
    t.text     "group_ids"
    t.text     "blog_ids"
    t.text     "resource_ids"
    t.text     "question_ids"
    t.text     "answer_ids"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "confirmed_at"
    t.integer  "confirmed_by"
    t.boolean  "delta",         :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
  end

  add_index "tags_bak", ["name"], :name => "name", :unique => true

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.boolean  "done"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "topics", :force => true do |t|
    t.integer  "group_id"
    t.string   "title"
    t.text     "content"
    t.text     "body"
    t.integer  "views_count"
    t.integer  "comments_count"
    t.integer  "hit_count"
    t.integer  "sticky_count"
    t.text     "like_by"
    t.integer  "created_by"
    t.text     "tags"
    t.boolean  "delta",           :default => true,  :null => false
    t.integer  "highlight",       :default => 0
    t.boolean  "is_announcement", :default => false
    t.boolean  "is_top",          :default => false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_data_statistics", :force => true do |t|
    t.text     "focus_user_on"
    t.integer  "focus_on_count",       :default => 0
    t.text     "focus_user_by"
    t.integer  "focus_by_count",       :default => 0
    t.text     "focus_group_on"
    t.integer  "focus_group_count",    :default => 0
    t.text     "focus_topic_on"
    t.integer  "focus_topic_count",    :default => 0
    t.text     "focus_question_on"
    t.integer  "focus_question_count", :default => 0
    t.text     "like_user_by"
    t.integer  "like_by_count",        :default => 0
    t.text     "like_user_on"
    t.integer  "like_on_count",        :default => 0
    t.text     "invite_user_on"
    t.integer  "invite_user_count",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "flash_link"
    t.integer  "created_by"
    t.datetime "deleted_at"
    t.integer  "views_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
