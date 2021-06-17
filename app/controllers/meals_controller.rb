class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  def index
    @meals = Meal.all
  end

  def new
    @user = User.find(params[:user_id])
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.save
    redirect_to meal_path(@meal)
  end

  def show
    set_meal
  end

  def edit
    set_meal
  end

  def update
    @meal.update(meal_params)
    redirect_to meal_path(@meal)
  end

  def destroy
    @meal.destroy
    redirect_to meals_path
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :price, :user)
  end

  def set_meal
    @meal = meal.find(params[:id])
  end
end
