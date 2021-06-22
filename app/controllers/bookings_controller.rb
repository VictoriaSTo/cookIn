class BookingsController < ApplicationController
    def my_bookings
    end

    def bookings_as_a_chef
        @bookings = Booking.where(meal: current_user.meals)
    end

    def bookings_as_an_eater
        @bookings = current_user.bookings
    end

    def create
        @booking = Booking.new(booking_params)
        @meal = Meal.find(params[:meal_id])
        @booking.user = current_user
        @booking.meal = @meal
               
        if @booking.save
          redirect_to my_eater_bookings_path
        else
          render :new
        end
    end

    def destroy
        @booking = Booking.find(params[:id])
        @booking.destroy
        redirect_to meals_path
    end

    private

    def booking_params
        params.require(:booking).permit(:date, :location)
    end
end
