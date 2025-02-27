# frozen_string_literal: true

module Promotions
  # Applies a discount when buying a minimum quantity of a product
  class BulkDiscount
    def initialize(product_codes:, min_quantity:, discount_price:)
      @product_codes = product_codes
      @min_quantity = min_quantity
      @discount_price = discount_price
    end

    def apply(checkout)
      checkout.line_items.each do |item|
        next unless @product_codes.include?(item.product.code) &&
                    item.quantity >= @min_quantity

        item.total_price = @discount_price * item.quantity
      end
    end
  end
end
