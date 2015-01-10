class AddRatingToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :rating, :integer
  end
end
