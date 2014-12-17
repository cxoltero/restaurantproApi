class RecipesController < ApplicationController
before_action :find_recipe, only: [:show, :edit, :update, :destroy]

def index
	@recipes = Recipe.all.order("created_at DESC")
	render json: @recipes, :include => [:image]
end

def new
	@recipe = Recipe.new
	render json: @recipe
end

def show
	render json: @recipe, :include => [:image]
end

def create
	@recipe = Recipe.new(recipe_params)
	if @recipe.save
		render json: @recipe, status: :created, location: @recipe
	else
		render json: @recipe.errors, status: :unprocessable_entity
	end
end

def edit
end

def update
	if @recipe.update(recipe_params)
		render json: @recipe
	else
		render json: @recipe.errors, status: :unprocessable_entity
	end
	head :no_content
end

def destroy
	@recipe.destroy
	head :no_content
end


private
def find_recipe
	@recipe = Recipe.find(params[:id])
end

def recipe_params
	params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
end

end
