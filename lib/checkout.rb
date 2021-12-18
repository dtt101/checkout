class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  # TODOL this isn't right
  def total
    @items.inject(0) do |total, item|
      total += item.price(@pricing_rules)
    end
  end
end