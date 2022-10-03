require_relative "meal"
require_relative "dish"
require 'dotenv/load'
require 'twilio-ruby'

class Order
  def initialize(meal, requester)
    # meal is an instance of Meal
    @meal = meal
    @requester = requester
  end

  def get_receipt
    # returns an itemised receipt with a grand total
    # fails if there the meal has no dishes in it
    receipt = "Receipt:\n"
    @meal.all.each { |dish| receipt << "- #{dish.name.capitalize}, £#{dish.price}\n" }
    receipt << "Total: £#{@meal.total_price}"
  end

  def order_meal(from, to)
    # returns a message through the twilio api
    # fails if there the meal has no dishes in it
    any_dishes?
    make_request_to_api(from, to)
  end

  private

  def any_dishes?
    fail "There are no dishes in your meal" if @meal.dishes.empty?
  end

  def make_request_to_api(from, to)
    message_list = @requester.messages
    message = message_list.create(
      body: "Thank you! Your order was placed and will be delivered before #{(Time.now + 3600).strftime("%k:%M")}",
      to: to,
      from: from
    )
    message.status
  end
end

# meal = Meal.new
# dish = Dish.new("food", 3)
# meal.add(dish)
# requester = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
# order = Order.new(meal, requester)
# from = '+15005550006'
# to = '+447926005117'
# order.order_meal(from, to)
