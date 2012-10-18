class CreateGoods < ActiveRecord::Migration
  def change
    create_table(:goods, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :name
      t.string :url
      t.string :avatar_url

      t.timestamps
    end
  end
end
