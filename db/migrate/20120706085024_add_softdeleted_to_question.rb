class AddSoftdeletedToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :deleted_by, :integer
    add_column :questions, :deleted_at, :datetime
  end
end
