require 'minitest/autorun'
require './lib/checkout'

describe Checkout do

  describe "#new" do
    it "creates a new checkout" do
      _(Checkout.new({})).must_be_instance_of Checkout
    end
  end

end


# Test data

# Basket: 001,002,003
# Total price expected: £66.78
# Basket: 001,003,001
# Total price expected: £36.95
# Basket: 001,002,001,003
# Total price expected: £73.76

# Promo rules

# If you spend over £60, then you get 10% of your purchase
# If you buy 2 or more lavender hearts then the price drops to £8.50.
# co = Checkout.new(promotional_rules)
# co.scan(item)
# co.scan(item)
# price = co.total
