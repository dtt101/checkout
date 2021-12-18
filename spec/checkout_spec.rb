require 'minitest/autorun'
require './lib/checkout'
require './lib/item'

describe Checkout do

  describe "#new" do
    it "creates a new checkout" do
      _(Checkout.new({})).must_be_instance_of Checkout
    end
  end

  describe "#scan" do
    it "adds a new item and returns true if the item is available" do
      co = Checkout.new({})
      item = Item.new("001", "Lavender heart", 9.25)
      _(co.scan(item)).must_equal true
    end

    it "does not add a new item and returns false if the item is unavailable" do
      co = Checkout.new({})
      item = Item.new("666", "Real Unicorn Horn", 100.25)
      _(co.scan(item)).must_equal false      
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

# Products

# Product code  | Name                   | Price
# ----------------------------------------------------------
# 001           | Lavender heart         | £9.25
# 002           | Personalised cufflinks | £45.00
# 003           | Kids T-shirt           | £19.95