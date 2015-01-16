class ChangeNameOfFieldProfile < ActiveRecord::Migration
  def up
  	remove_column :profiles, :Name
  	remove_column :profiles, :Occupation
  	add_column :profiles, :name, :string
  	add_column :profiles, :occupation, :string
  end

  def down
  	remove_column :profiles, :name
  	remove_column :profiles, :occupation
  	add_column :profiles, :Name, :string
  	add_column :profiles, :Occupation, :string
  end
end
