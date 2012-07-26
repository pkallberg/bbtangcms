class RenameOwneridOnSubject < ActiveRecord::Migration
  def change
    rename_column :subjects, :created_by_id, :created_by
    rename_column :subjects, :updated_by_id, :updated_by
  end
end
