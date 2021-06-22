class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  def index
    @meals = Meal.all
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    if @meal.save
      redirect_to meal_path(@meal)
    else
      render :new
    end
  end

  def show
    set_meal
    @booking = Booking.new
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
    params.require(:meal).permit(:name, :description, :price)
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end
end
