class Meal
  attr_reader :dishes

  def initialize
    @dishes = []
  end

  def add(dish)
    # adds a dish to the meal
    @dishes << dish
  end

  def all
    # lists all the dishes
    any_dishes?
    @dishes
  end

  def total_price
    # returns the total price of all the dishes in the meal
    any_dishes?
    @dishes.map { |dish| dish.price }.sum
  end

  private

  def any_dishes?
    fail "There are no dishes in your meal" if @dishes.empty?
  end
end
