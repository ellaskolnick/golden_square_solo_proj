require 'order'
require 'meal'
require 'dish'
require 'dotenv/load'
require 'twilio-ruby'

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
      from = '+15005550006'
      to = '+15005550009'
      message = double :message, status: "queued"
      message_list = double :message_list, create: message
      requester = double :requester, messages: message_list
      expect(message_list).to receive(:create)
        .with(
          body: "Thank you! Your order was placed and will be delivered before #{(Time.now + 3600).strftime("%k:%M")}",
          to: to,
          from: from
        ).and_return(message)
        expect(message).to receive(:status).and_return("queued")

      order = Order.new(meal, requester)
      order.order_meal(from, to)
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
      from = '+15005550006'
      to = '+15005550009'
      order = Order.new(meal, requester)
      expect{ order.order_meal(from, to) }.to raise_error "There are no dishes in your meal"
    end
  end
end
