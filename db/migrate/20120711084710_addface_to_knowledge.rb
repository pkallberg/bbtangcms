class AddfaceToKnowledge < ActiveRecord::Migration
  def change
    add_column :knowledges, :face_file_name, :string
    add_column :knowledges, :face_content_type, :string
    add_column :knowledges, :face_file_size, :string
  end


end
