require 'meal'
require 'dish'

RSpec.describe "meal integration" do
  context "one dish in meal" do
    it "returns array with dish" do
      dish = Dish.new("food", 3)
      meal = Meal.new
      meal.add(dish)
      expect(meal.all).to eq [dish]
    end

    it "returns the price of that dish" do
      dish = Dish.new("food", 3)
      meal = Meal.new
      meal.add(dish)
      expect(meal.total_price).to eq 3
    end
  end

  context "multiple dishes in meal" do
    it "returns array with dishes" do
      dish = Dish.new("food", 3)
      dish2 = Dish.new("food2", 4)
      meal = Meal.new
      meal.add(dish)
      meal.add(dish2)
      expect(meal.all).to eq [dish, dish2]
    end

    it "returns the total price of all the dishes" do
      dish = Dish.new("food", 3)
      dish2 = Dish.new("food2", 4)
      meal = Meal.new
      meal.add(dish)
      meal.add(dish2)
      expect(meal.total_price).to eq 7
    end
  end
end
