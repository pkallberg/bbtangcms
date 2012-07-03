class CreateCmsRoles < ActiveRecord::Migration
  def change
    create_table :cms_roles do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end
end
