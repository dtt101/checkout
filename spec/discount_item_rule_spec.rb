require 'minitest/autorun'
require './lib/promotional_rules/discount_item_rule'

describe Item do

  describe "#new" do
    it "creates a new DiscountItemRule" do
      _(DiscountItemRule.new(applies_to: :item, item_code: "001", item_discount_price: 8.50, minimum_item_count: 2)).must_be_instance_of DiscountItemRule
    end
  end

  describe "#apply" do
    it "applies the discounts to the relevant supplied items" do
      items = [
        Item.new("001", "Lavender Heart", 9.25),
        Item.new("001", "Lavender Heart", 9.25),
        Item.new("002", "Toast", 1.01),
      ]
      rule = DiscountItemRule.new(applies_to: :item, item_code: "001", item_discount_price: 8.50, minimum_item_count: 2)
      discounted_items = rule.apply(items)
      _(discounted_items[0].price).must_equal 8.50
      _(discounted_items[1].price).must_equal 8.50
      _(discounted_items[2].price).must_equal 1.01
    end
  end
end