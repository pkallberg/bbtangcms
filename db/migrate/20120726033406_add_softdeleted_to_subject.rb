class AddSoftdeletedToSubject < ActiveRecord::Migration
  def change

    change_table :subjects do |t|
      t.timestamps
    end
    add_column :subjects, :deleted_by_id, :integer
    add_column :subjects, :deleted_at, :datetime
    add_column :subjects, :created_by_id, :integer
    add_column :subjects, :updated_by_id, :integer
    #add_column :subjects, :updated_at, :datetime
    #add_column :subjects, :created_at, :datetime
  end

end
