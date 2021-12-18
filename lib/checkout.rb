class Checkout

  attr_reader :items

  def initialize(promotional_rules)
    @items = []
  end

  def scan(item) 
    @items.push(item)
  end

  def total
    @items.map(&:price).sum
  end

end