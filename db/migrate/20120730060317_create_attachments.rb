class CreateAttachments < ActiveRecord::Migration
  def change
    create_table(:attachments, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.string :attachment_file_size
      t.string :purpose
      t.text :note
      t.integer :deleted_by_id
      t.datetime :deleted_at
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
