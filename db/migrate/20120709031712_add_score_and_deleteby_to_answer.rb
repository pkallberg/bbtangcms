class AddScoreAndDeletebyToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :deleted_by, :integer
    add_column :answers, :score, :integer
  end
end
