class AddColumnsToUsers < ActiveRecord::Migration

  def up
    add_column :users, :provider, :string
   	add_column :users, :uid, :string
  end

  def down
  	remove_column :users, :provider
   	remove_column :users, :uid
  end

end
