require 'order'

RSpec.describe Order do
  context "one dish is added to the meal" do
    it "returns receipt with item and total" do
      dish = double :dish, price: 3, name: "food"
      meal = double :meal, all: [dish], total_price: 3
      requester = double :requester
      order = Order.new(meal, requester)
      expect(order.get_receipt).to eq "Receipt:\n- Food, £3\nTotal: £3"
    end

    it "returns message from API" do
      dish = double :dish, price: 3, name: "food"
      meal = double :meal, all: [dish], total_price: 3, dishes: [dish]
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
      meal = double :meal, dishes: []
      requester = double :requester
      from = '+15005550006'
      to = '+15005550009'
      expect(meal).to receive(:dishes).and_return([])
      order = Order.new(meal, requester)
      expect{ order.order_meal(from, to) }.to raise_error "There are no dishes in your meal"
    end
  end
end
