class RecipesController < ApplicationController
  before_action :require_login

  def index
    @recipes = current_user.recipes.order(:id)
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
  end

  def new
    @recipe = current_user.recipes.build
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "新規予定作成しました!"
    else
      @errors = @recipe.errors.full_messages
      render :new
    end
  end

  def update
    @recipe = current_user.recipes.find(params[:id])

    if @recipe.update_attributes(recipe_params)
      redirect_to recipe_path(@recipe), notice: "進度予定更新しました!"
    else
      @errors = @recipe.errors.full_messages
      render :edit
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path, notice: "#{@recipe.name}を削除しました!"
    else
      @errors = @recipe.errors.full_messages
      render :index
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
end