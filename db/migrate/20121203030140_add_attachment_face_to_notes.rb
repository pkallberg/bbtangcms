class AddAttachmentFaceToNotes < ActiveRecord::Migration
  def self.up
    change_table :notes do |t|
      t.has_attached_file :face
    end
  end

  def self.down
    drop_attached_file :notes, :face
  end
end
