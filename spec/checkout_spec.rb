require 'minitest/autorun'
require './lib/checkout'
require './lib/item'
require './lib/promotional_rules/discount_total_rule'
require './lib/promotional_rules/discount_item_rule'

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
      @heart = Item.new("001", "Lavender heart", 9.25)
      @cufflinks = Item.new("002", "Personalised cufflinks", 45.00)
      @tshirt = Item.new("003", "Kids T-shirt", 19.95)
      @promotional_rules = [
        DiscountTotalRule.new(applies_to: :total, minimum_spend: 60, discount_percentage: 10),
        DiscountItemRule.new(applies_to: :item, item_code: "001", item_discount_price: 8.50, minimum_item_count: 2)
      ]
    end

    it "calculates the total price with no discounts" do
      co = Checkout.new({})
      co.scan(@heart)
      co.scan(@cufflinks)
      _(co.total()).must_equal "£54.25"
    end
    
    it "correctly calculates the discounts for items 001,002,003" do
      co = Checkout.new(@promotional_rules)
      co.scan(@heart)
      co.scan(@cufflinks)
      co.scan(@tshirt)
      _(co.total()).must_equal "£66.78"
    end

    it "correctly calculates the discounts for items 001,003,001" do
      co = Checkout.new(@promotional_rules)
      co.scan(@heart)
      co.scan(@tshirt)
      co.scan(@heart)
      _(co.total()).must_equal "£36.95"
    end
    
    it "correctly calculates the discounts for items 001,002,001,003" do
      co = Checkout.new(@promotional_rules)
      co.scan(@heart)
      co.scan(@cufflinks)
      co.scan(@heart)
      co.scan(@tshirt)
      _(co.total()).must_equal "£73.76"
    end    
  end

  describe "#total with multiple item promotional rules" do
    before do
      @heart = Item.new("001", "Lavender heart", 9.25)
      @cufflinks = Item.new("002", "Personalised cufflinks", 45.00)
      @tshirt = Item.new("003", "Kids T-shirt", 19.95)
      @promotional_rules = [
        DiscountTotalRule.new(applies_to: :total, minimum_spend: 60, discount_percentage: 10),
        DiscountItemRule.new(applies_to: :item, item_code: "001", item_discount_price: 8.50, minimum_item_count: 2),
        DiscountItemRule.new(applies_to: :item, item_code: "003", item_discount_price: 5.00, minimum_item_count: 2)
      ]
    end

    it "correctly calculates the discounts for items 003,003,001" do
      co = Checkout.new(@promotional_rules)
      co.scan(@tshirt)
      co.scan(@tshirt)
      co.scan(@heart)
      _(co.total()).must_equal "£19.25"
    end    
  end
end
