class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :set_image, only: [:show]
  def index
    if params[:query].present?
      @meals = Meal.search_by_name_and_description(params[:query])
    else
      @meals = Meal.all
    end
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
    @booking = Booking.new
    render layout: "show"

    p "======", @image
  end

  def edit
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

  def set_image
    @image = @meal.background_image
  end
end
