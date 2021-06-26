class AddMealTypeToMeal < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :meal_type, :string
  end
end
