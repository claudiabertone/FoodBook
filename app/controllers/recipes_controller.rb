class RecipesController < ApplicationController


  def home
    @recipes = Recipe.all

  end

  def show
    # get the user with id :id
    @recipe = Recipe.find(params[:id])
  end



    def new
      #@ingredients = Array.new(6) { Ingredient.new }
      @recipe = Recipe.new
      3.times {@recipe.ingredients.build}
    end


  def edit

    @recipe = Recipe.find(params[:id])

  end


  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      flash[:success] = 'Ricetta modificata!'
      redirect_to :action => 'show', :id => @recipe
    else
      render 'edit'
    end
  end


  def destroy
    # delete the user starting from her id
    Recipe.find(params[:id]).destroy
    flash[:success] = 'Ricetta cancellata!'
    redirect_to root_path
  end



  def cookbook
    @recipes = Recipe.find_all_by_user_id(current_user)
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save

      flash[:success] = 'Ricetta registrata'

      redirect_to root_url
    else
      render 'new'
    end

  end

  private
  def recipe_params
    params.require(:recipe).permit(:name,:piatto,:cucina, :vegetariana, :vegana, :latticini, :glutine, :descrizione, ingredients_attributes: [:id, :ingrediente, :quantit, :tipoquantit])
  end




  def search
    @search = Recipe.search(params[:search])

  end











end