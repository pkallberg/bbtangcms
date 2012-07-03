class CreateCuPermits < ActiveRecord::Migration
  def change
    create_table :cu_permits do |t|
      t.integer :user_id
      t.integer :permit_id

      t.timestamps
    end
  end
end
