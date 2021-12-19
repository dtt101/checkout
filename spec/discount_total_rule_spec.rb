require 'minitest/autorun'
require './lib/promotional_rules/discount_total_rule'

describe Item do

  describe "#new" do
    it "creates a new DiscountTotalRule" do
      _(DiscountTotalRule.new(applies_to: :total, minimum_spend: 60, discount_percentage: 10)).must_be_instance_of DiscountTotalRule
    end
  end

  describe "#apply" do
    it "applies the discounts to the supplied total and returns difference" do
      total = 100
      rule = DiscountTotalRule.new(applies_to: :total, minimum_spend: 5, discount_percentage: 10)
      discount = rule.apply(total)
      discounted_total = total - discount
      _(discounted_total).must_equal 90
    end
  end
end