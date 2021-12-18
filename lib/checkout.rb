class Checkout

  attr_reader :items

  def initialize(promotional_rules)
    @total_promotional_rules = promotional_rules.select { |rule| rule.applies_to == :total }
    @item_promotional_rules = promotional_rules.select { |rule| rule.applies_to == :item }
    @items = []
  end

  def scan(item) 
    @items.push(item)
  end

  def total
    discounted_items = apply_item_promotional_rules(@items, @item_promotional_rules)    
    total_after_item_discounts = discounted_items.map(&:price).sum
    total_after_all_discounts = apply_total_promotional_rules(total_after_item_discounts, @total_promotional_rules)
    '£%.2f' % total_after_all_discounts
  end

  private

  def apply_item_promotional_rules(items_before_discounts, promotional_rules)
    promotional_rules.reduce(items_before_discounts) do |items_after_discounts, rule|
      rule.apply(items_after_discounts)
    end
  end

  def apply_total_promotional_rules(total_before_discounts, promotional_rules)
    promotional_rules.reduce(total_before_discounts) do |total_after_discounts, rule|
      total_after_discounts - rule.apply(total_after_discounts)
    end    
  end

end