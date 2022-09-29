```ruby

class Order
  def initialize(meal)
    # meal is an instance of Meal
  end

  def get_receipt
    # returns an itemised receipt with a grand total
    # fails if there the meal has no dishes in it
  end

  def order_meal
    # returns a message through the twilio api
  end
end

class Meal
  def initialize
    @dishes = []
  end

  def add(dish)
    # adds a dish to the meal
  end

  def all
    # lists all the dishes
  end

  def total_price
    # returns the total price of all the dishes in the meal
  end
end

class Dish
  attr_reader :name, :price

  def initialize(name, price)
  end
end

```

# TESTS!!!
(do all intergrated tests as unit tests with doubles!!)

```ruby

#1
dish = Dish.new("food", 3)
meal = Meal.new
meal.add(dish)
order = Order.new(meal)
order.get_receipt # => "- food, £3\nTotal: £3"

#2
dish = Dish.new("food", 3)
dish2 = Dish.new("food2", 4)
meal = Meal.new
meal.add(dish)
order = Order.new(meal)
order.get_receipt # => "- food, £3\n- food2, £4\nTotal: £7"

#3
dish = Dish.new("food", 3)
meal = Meal.new
meal.add(dish)
order = Order.new(meal)
order.order_meal # => DO THIS LATERRRRR

#4
meal = Meal.new
order = Order.new(meal)
order.get_receipt # => "There are no dishes in your meal"

#5
meal = Meal.new
order = Order.new(meal)
order.order_meal # => "There are no dishes in your meal"

#1
dish = Dish.new("food", 3)
meal = Meal.new
meal.add(dish)
meal.all # => [dish]

#2
dish = Dish.new("food", 3)
dish2 = Dish.new("food2", 4)
meal = Meal.new
meal.add(dish)
meal.all # => [dish, dish2]

#3
meal = Meal.new
meal.all # => "There are no dishes in your meal"

#4
dish = Dish.new("food", 3)
meal = Meal.new
meal.add(dish)
meal.total_price # => 3

#5
dish = Dish.new("food", 3)
dish2 = Dish.new("food2", 4)
meal = Meal.new
meal.add(dish)
meal.total_price # => 7

#6
meal = Meal.new
meal.total_price # => "There are no dishes in your meal"

#1
dish = Dish.new("food", 3)
dish.name # => "food"

#2
dish = Dish.new("food", 3)
dish.price # => 3

```
