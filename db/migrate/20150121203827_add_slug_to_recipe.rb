class AddSlugToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :slug, :string
  end
end
