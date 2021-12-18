class DiscountItemRule 

  attr_reader :applies_to

  def initialize(applies_to:, item_code:, item_discount_price:, minimum_item_count:)
    @applies_to = applies_to
    @item_code = item_code
    @item_discount_price = item_discount_price
    @minimum_item_count = minimum_item_count
  end

  def apply(items)
    apply_discount?(items) ? apply_discount(items) : items
  end

  private

  def apply_discount?(items)
    selected_items = items.select{ |i| i.code == @item_code}
    selected_items.length >= @minimum_item_count
  end

  def apply_discount(items)
    items.each do |item|
      if item.code == @item_code
        item.price = @item_discount_price
      end
    end
  end 
end