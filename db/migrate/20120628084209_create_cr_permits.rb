class CreateCrPermits < ActiveRecord::Migration
  def change
    create_table :cr_permits do |t|
      t.integer :cms_role_id
      t.integer :permit_id
      t.string :type

      t.timestamps
    end
  end
end
