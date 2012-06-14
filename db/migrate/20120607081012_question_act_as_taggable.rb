class QuestionActAsTaggable < ActiveRecord::Migration
  def change
    remove_column :questions, :tags
    remove_column :questions, :auto_tags
  end
end
