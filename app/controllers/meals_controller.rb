class MealsController < ApplicationController
  skip_after_action :verify_authorized, only: [:my_meals]
  after_action :verify_policy_scoped, only: :my_meals, unless: :skip_pundit?
  
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :set_image, only: [:show]
  def index
    if params[:query].present?
      @meals = policy_scope(Meal).search_by_name_and_description(params[:query])
    else
      @meals = policy_scope(Meal)
    end
  end

  def my_meals
    @meals = policy_scope(Meal).where(user: current_user)
  end

  def new
    @meal = Meal.new
    authorize @meal
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    authorize @meal
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
    params.require(:meal).permit(:name, :description, :meal_type, :price)
  end

  def set_meal
    @meal = Meal.find(params[:id])
    authorize @meal
  end

  def set_image
    @image = @meal.background_image
  end
end
