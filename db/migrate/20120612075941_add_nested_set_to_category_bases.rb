class AddNestedSetToCategoryBases < ActiveRecord::Migration
  def change
    add_column :category_bases, :parent_id, :integer

    add_column :category_bases, :lft, :integer

    add_column :category_bases, :rgt, :integer

    add_column :category_bases, :depth, :integer

  end
end
