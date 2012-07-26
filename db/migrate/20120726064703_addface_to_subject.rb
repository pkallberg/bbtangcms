class AddfaceToSubject < ActiveRecord::Migration
  def up
    add_column :subjects, :face_file_name, :string
    add_column :subjects, :face_content_type, :string
    add_column :subjects, :face_file_size, :string
  end

  def down
    remove_column :subjects, :face_file_name, :string
    remove_column :subjects, :face_content_type, :string
    remove_column :subjects, :face_file_size, :string
  end
end
