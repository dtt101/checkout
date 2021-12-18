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
    it "adds a new item" do
      co = Checkout.new({})
      item = Item.new("001", "Lavender heart", 9.25)
      _(co.items.length()).must_equal 0
      co.scan(item)
      _(co.items.length()).must_equal 1
    end
  end

  describe "#total" do

    before do
      # TODO create promo rules here to pass to class
      @heart = Item.new("001", "Lavender heart", 9.25)
      @cufflinks = Item.new("002", "Personalised cufflinks", 45.00)
      @tshirt = Item.new("003", "Kids T-shirt", 19.95)
    end

    it "calculates the total price with no discounts" do
      co = Checkout.new({})
      co.scan(@heart)
      co.scan(@cufflinks)
      _(co.total()).must_equal 54.25
    end
    
    it "correctly calculates the discounts for items 001,002,003" do
      co = Checkout.new({})
      co.scan(@heart)
      co.scan(@cufflinks)
      co.scan(@tshirt)
      _(co.total()).must_equal 66.78
    end

    it "correctly calculates the discounts for items 001,003,001" do
      co = Checkout.new({})
      co.scan(@heart)
      co.scan(@tshirt)
      co.scan(@heart)
      _(co.total()).must_equal 36.95
    end
    
    it "correctly calculates the discounts for items 001,002,001,003" do
      co = Checkout.new({})
      co.scan(@heart)
      co.scan(@cufflinks)
      co.scan(@heart)
      co.scan(@tshirt)
      _(co.total()).must_equal 73.76
    end    
  end

end


# Test data

# Promo rules

# If you spend over £60, then you get 10% of your purchase
# If you buy 2 or more lavender hearts then the price drops to £8.50.


