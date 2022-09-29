require 'order'
require 'meal'
require 'dish'
require 'dotenv/load'

RSpec.describe "order integration" do
  context "one dish is added to the meal" do
    it "returns receipt with item and total" do
      dish = Dish.new("food", 3)
      requester = double :requester
      meal = Meal.new
      meal.add(dish)
      order = Order.new(meal, requester)
      expect(order.get_receipt).to eq "Receipt:\n- Food, £3\nTotal: £3"
    end

    it "message from API status is sent" do
      dish = Dish.new("food", 3)
      meal = Meal.new
      meal.add(dish)
      requester = double :requester
      allow(requester).to receive(:new)
        .with(ENV['TWIOLIO_ACCOUNT_SID'], ENV['TWIOLIO_AUTH_TOKEN'])
        .and_return(client)
      allow(client).to receive(:messages).to receive(:create).to receive(:sid)

      order = Order.new(meal, requester)
      order.order_meal
    end
  end

  context "multiple dishes are added to the meal" do
    it "returns receipt with items and total" do
      dish = Dish.new("food", 3)
      dish2 = Dish.new("food2", 4)
      requester = double :requester
      meal = Meal.new
      meal.add(dish)
      meal.add(dish2)
      order = Order.new(meal, requester)
      expect(order.get_receipt).to eq "Receipt:\n- Food, £3\n- Food2, £4\nTotal: £7"
    end
  end

  context "no dishes in meal" do
    it "fails" do
      meal = Meal.new
      requester = double :requester
      order = Order.new(meal, requester)
      expect{ order.get_receipt }.to raise_error "There are no dishes in your meal"
    end

    it "fails" do
      meal = Meal.new
      requester = double :requester
      order = Order.new(meal, requester)
      expect{ order.order_meal }.to raise_error "There are no dishes in your meal"
    end
  end
end
