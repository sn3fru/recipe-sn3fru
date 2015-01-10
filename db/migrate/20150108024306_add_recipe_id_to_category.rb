class AddRecipeIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :recipe_id, :integer
  end
end
