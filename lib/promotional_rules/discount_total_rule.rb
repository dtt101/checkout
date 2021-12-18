class DiscountTotalRule 

  attr_reader :applies_to

  def initialize(applies_to:, minimum_spend:, discount_percentage:)
    @applies_to = applies_to
    @minimum_spend = minimum_spend
    @discount_percentage = discount_percentage
  end

  def apply(total)
    apply_discount?(total) ? apply_discount(total) : 0
  end

  private

  def apply_discount?(total)
    total > @minimum_spend
  end

  def apply_discount(total)
    total * @discount_percentage / 100
  end 
end