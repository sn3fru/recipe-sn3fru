require 'test_helper'

class TreeRecipesControllerTest < ActionController::TestCase
  setup do
    @tree_recipe = tree_recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tree_recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tree_recipe" do
    assert_difference('TreeRecipe.count') do
      post :create, tree_recipe: { description: @tree_recipe.description }
    end

    assert_redirected_to tree_recipe_path(assigns(:tree_recipe))
  end

  test "should show tree_recipe" do
    get :show, id: @tree_recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tree_recipe
    assert_response :success
  end

  test "should update tree_recipe" do
    patch :update, id: @tree_recipe, tree_recipe: { description: @tree_recipe.description }
    assert_redirected_to tree_recipe_path(assigns(:tree_recipe))
  end

  test "should destroy tree_recipe" do
    assert_difference('TreeRecipe.count', -1) do
      delete :destroy, id: @tree_recipe
    end

    assert_redirected_to tree_recipes_path
  end
end
