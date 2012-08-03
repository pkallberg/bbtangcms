class CreateNews < ActiveRecord::Migration
  def change
    create_table(:news, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :title
      t.text :content
      t.text :body
      t.integer :thanks_count
      t.integer :views_count
      t.string :source_info
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :deleted_by_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
