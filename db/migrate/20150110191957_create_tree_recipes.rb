class CreateTreeRecipes < ActiveRecord::Migration
  def change
    create_table :tree_recipes do |t|
      t.string :description

      t.timestamps
    end
  end
end
