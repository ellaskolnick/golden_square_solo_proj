require 'order'

RSpec.describe Order do
  context "one dish is added to the meal" do
    it "returns receipt with item and total" do
      dish = double :dish
      meal = double :meal
      requester = double :requester
      expect(meal).to receive(:all).and_return([dish])
      expect(meal).to receive(:total_price).and_return(3)
      expect(dish).to receive(:price).and_return(3)
      expect(dish).to receive(:name).and_return("food")
      order = Order.new(meal, requester)
      expect(order.get_receipt).to eq "Receipt:\n- Food, £3\nTotal: £3"
    end

    xit "returns message from API" do
      dish = Dish.new("food", 3)
      meal = Meal.new
      requester = double :requester
      meal.add(dish)
      order = Order.new(meal, requester)
      order.order_meal # => DO THIS LATERRRRR
    end
  end

  context "multiple dishes are added to the meal" do
    it "returns receipt with items and total" do
      dish = double :dish
      dish2 = double :dish
      meal = double :meal
      requester = double :requester
      expect(meal).to receive(:all).and_return([dish, dish2])
      expect(meal).to receive(:total_price).and_return(7)
      expect(dish).to receive(:price).and_return(3)
      expect(dish).to receive(:name).and_return("food")
      expect(dish2).to receive(:price).and_return(4)
      expect(dish2).to receive(:name).and_return("food2")
      order = Order.new(meal, requester)
      expect(order.get_receipt).to eq "Receipt:\n- Food, £3\n- Food2, £4\nTotal: £7"
    end
  end

  context "no dishes in meal" do
    it "fails" do
      meal = double :meal
      requester = double :requester
      expect(meal).to receive(:all).and_raise("There are no dishes in your meal")
      order = Order.new(meal, requester)
      expect{ order.get_receipt }.to raise_error "There are no dishes in your meal"
    end

    it "fails" do
      meal = double :meal
      requester = double :requester
      expect(meal).to receive(:dishes).and_return([])
      order = Order.new(meal, requester)
      expect{ order.order_meal }.to raise_error "There are no dishes in your meal"
    end
  end
end
