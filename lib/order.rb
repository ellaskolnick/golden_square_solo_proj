require 'twilio-ruby'
require 'dotenv/load'

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

  def order_meal
    # returns a message through the twilio api
    # fails if there the meal has no dishes in it
    any_dishes?
  end

  private

  def any_dishes?
    fail "There are no dishes in your meal" if @meal.dishes.empty?
  end

  def make_request_to_api(from, to)
    client = @requester.new(ENV['TWIOLIO_ACCOUNT_SID'], ENV['TWIOLIO_AUTH_TOKEN'])
    message = client.messages.create(
      body: "Thank you! Your order was placed and will be delivered before #{(Time.now + 3600).strftime("%k:%M")}",
      to: from,
      from: to
    )
  end
end
