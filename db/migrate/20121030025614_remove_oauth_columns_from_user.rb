class RemoveOauthColumnsFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :omniauth_type
        remove_column :users, :uid
      end

  def down
    add_column :users, :uid, :string
    add_column :users, :omniauth_type, :string
  end
end
