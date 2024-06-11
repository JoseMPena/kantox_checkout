# frozen_string_literal: true

module Promotions
  # Applies promotion rules to add a free item for each applicable product in the checkout
  class BuyOneGetOne
    def initialize(product_codes)
      @product_codes = product_codes
    end

    def apply(checkout)
      checkout.line_items.each do |item|
        next unless @product_codes.include?(item.product.code)

        item.total_price = item.product.price * (item.quantity / 2.0).ceil
      end
    end
  end
end
