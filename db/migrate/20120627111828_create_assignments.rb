class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :user_id, :null => false
      t.integer :cms_role_id, :null => false

      t.timestamps
    end

    add_index :assignments, [:user_id, :cms_role_id]
  end

  def down
    #drop_table :user_roles
    drop_table :assignments
  end
end
