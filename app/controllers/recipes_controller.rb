class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_categories, only: [:create, :edit]

	def index
		@recipe = Recipe.all.order("created_at DESC")

		if @reviews.blank?
			@avg_review = 0
		else
			@avg_review = @reviews.average(:rating).round(2)
		end		

	end

	def show
		@reviews = Review.where(recipe_id: @recipe.id).order("created_at DESC")
		
		if @reviews.blank?
			@avg_review = 0
		else
			@avg_review = @reviews.average(:rating).round(2)
		end

	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Successfully created new recipe"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end


	def set_categories
		@categories = Category.all
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :rating, :category_id, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end



end
