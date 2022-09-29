require 'dish'

RSpec.describe Dish do
  context "readers" do
    it "returns the dish name" do
      dish = Dish.new("food", 3)
      expect(dish.name).to eq "food"
    end

    it "returns the dish price" do
      dish = Dish.new("food", 3)
      expect(dish.price).to eq 3
    end
  end
end
