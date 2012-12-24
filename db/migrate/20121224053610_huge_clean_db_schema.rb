class HugeCleanDbSchema < ActiveRecord::Migration
  def up
    drop_table :ads
    drop_table :tags_bak
    drop_table :tasks
    drop_table :topics
    drop_table :user_data_statistics
    drop_table :videos
    drop_table :astests
    drop_table :cms_module_configs
    drop_table :cms_module_types
    drop_table :cms_modules
    drop_table :cms_pages
    drop_table :configurations
    drop_table :expert_fields
    drop_table :ezines
    drop_table :favorites
    drop_table :focus_on_groups
    drop_table :group_categories
    drop_table :group_user_roles
    drop_table :groups
    drop_table :groups_users_roles
    drop_table :knowledgebase_categories
    drop_table :knowledgebase_nodes
    drop_table :login_logs
    drop_table :mom_shows
    drop_table :news
    drop_table :pictures
    drop_table :preferences
    drop_table :roles
    drop_table :setting_subjects
    drop_table :setting_types
    drop_table :show_categories
    drop_table :show_comments
    drop_table :show_images
    drop_table :subjects

    remove_column :profiles, :province
    remove_column :profiles, :town
    remove_column :profiles, :child_birthday
    remove_column :profiles, :child_gender
    remove_column :profiles, :profession
    remove_column :profiles, :modules
    remove_column :profiles, :posts_count
    remove_column :profiles, :notify_via_email
    remove_column :profiles, :notify_on_new_articles
    remove_column :profiles, :notify_on_comments
    remove_column :profiles, :blacklist
    remove_column :profiles, :recently_visits
    remove_column :profiles, :like_by_count
    remove_column :profiles, :subject
    remove_column :profiles, :focus_tags_on
    remove_column :profiles, :user_data_statistic_id
    remove_column :profiles, :delta
    remove_column :profiles, :baby_gender

    remove_column :answers, :opposition_count
    remove_column :answers, :opposition_ids
    remove_column :answers, :approval_count
    remove_column :answers, :approval_ids
    remove_column :answers, :no_help_count
    remove_column :answers, :no_help_ids
    remove_column :answers, :delta
    
    remove_column :knowledges, :knowledgebase_category_id
    remove_column :knowledges, :delta

    remove_column :questions, :delta
  end

  def down
  end
end
