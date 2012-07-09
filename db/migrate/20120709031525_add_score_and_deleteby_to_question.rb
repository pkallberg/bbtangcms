class AddScoreAndDeletebyToQuestion < ActiveRecord::Migration
  def change
    #add_column :questions, :deleted_by, :integer
    #add_column :questions, :deleted_at, :datetime
    add_column :questions, :score, :integer

  end
end
