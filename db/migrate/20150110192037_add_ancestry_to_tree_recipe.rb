class AddAncestryToTreeRecipe < ActiveRecord::Migration
  def change
    add_column :tree_recipes, :ancestry, :string, index: true
  end
end
