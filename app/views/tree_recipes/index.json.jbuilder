json.array!(@tree_recipes) do |tree_recipe|
  json.extract! tree_recipe, :id, :description
  json.url tree_recipe_url(tree_recipe, format: :json)
end
