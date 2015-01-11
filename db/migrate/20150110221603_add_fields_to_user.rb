class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_reference :users, :profile, index: true
    add_reference :users, :TreeRecipe, index: true
  end
end
