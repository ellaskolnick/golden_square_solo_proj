require 'meal'

RSpec.describe Meal do
  context "one dish in meal" do
    it "returns array with dish" do
      dish = double :dish
      meal = Meal.new
      meal.add(dish)
      expect(meal.all).to eq [dish]
    end

    it "returns the price of that dish" do
      dish = double :dish
      expect(dish).to receive(:price).and_return(3)
      meal = Meal.new
      meal.add(dish)
      expect(meal.total_price).to eq 3
    end
  end

  context "multiple dishes in meal" do
    it "returns array with dishes" do
      dish = double :dish
      dish2 = double :dish
      meal = Meal.new
      meal.add(dish)
      meal.add(dish2)
      expect(meal.all).to eq [dish, dish2]
    end

    it "returns the total price of all the dishes" do
      dish = double :dish
      expect(dish).to receive(:price).and_return(3)
      dish2 = double :dish
      expect(dish2).to receive(:price).and_return(4)
      meal = Meal.new
      meal.add(dish)
      meal.add(dish2)
      expect(meal.total_price).to eq 7
    end
  end

  context "no dishes in meal" do
    it "fails" do
      meal = Meal.new
      expect{ meal.all }.to raise_error "There are no dishes in your meal"
    end

    it "fails" do
      meal = Meal.new
      expect{ meal.total_price }.to raise_error "There are no dishes in your meal"
    end
  end
end
