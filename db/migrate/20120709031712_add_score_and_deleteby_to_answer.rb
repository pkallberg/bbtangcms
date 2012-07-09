class AddScoreAndDeletebyToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :deleted_by, :integer
  end
end
