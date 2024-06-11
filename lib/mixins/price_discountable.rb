module PriceDiscountable
  def apply(checkout)
    checkout.line_items.each do |item|
      next unless applicable?(item)

      item.final_price = discounted_price_quantity(item.original_price, item.quantity)
    end
  end
end