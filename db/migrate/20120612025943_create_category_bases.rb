class CreateCategoryBases < ActiveRecord::Migration
  def change
    create_table :category_bases do |t|
      t.string :name
      t.string :type
      #t.integer :category_type #eg: 0 timelines;1 categories;2 identities
      t.text :description
      t.timestamps
    end
  end
end
