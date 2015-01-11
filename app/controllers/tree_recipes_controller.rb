class TreeRecipesController < ApplicationController
  before_action :set_tree_recipe, only: [:show, :edit, :update, :destroy]

  # GET /tree_recipes
  # GET /tree_recipes.json
  def index
    @tree_recipes = TreeRecipe.all
  end

  # GET /tree_recipes/1
  # GET /tree_recipes/1.json
  def show
  end

  # GET /tree_recipes/new
  def new
    @tree_recipe = TreeRecipe.new
  end

  # GET /tree_recipes/1/edit
  def edit
  end

  # POST /tree_recipes
  # POST /tree_recipes.json
  def create
    @tree_recipe = TreeRecipe.new(tree_recipe_params)

    respond_to do |format|
      if @tree_recipe.save
        format.html { redirect_to @tree_recipe, notice: 'Tree recipe was successfully created.' }
        format.json { render :show, status: :created, location: @tree_recipe }
      else
        format.html { render :new }
        format.json { render json: @tree_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tree_recipes/1
  # PATCH/PUT /tree_recipes/1.json
  def update
    respond_to do |format|
      if @tree_recipe.update(tree_recipe_params)
        format.html { redirect_to @tree_recipe, notice: 'Tree recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @tree_recipe }
      else
        format.html { render :edit }
        format.json { render json: @tree_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tree_recipes/1
  # DELETE /tree_recipes/1.json
  def destroy
    @tree_recipe.destroy
    respond_to do |format|
      format.html { redirect_to tree_recipes_url, notice: 'Tree recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tree_recipe
      @tree_recipe = TreeRecipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tree_recipe_params
      params.require(:tree_recipe).permit(:description)
    end
end
