class AddRecipeIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :recipe_id, :integer
  end
end
