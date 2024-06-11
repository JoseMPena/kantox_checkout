# frozen_string_literal: true

require 'promotion'
require 'pry-byebug'

module Promotions
  # Applies promotion rules to add a free item for each applicable product in the checkout
  class BuyOneGetOne < ::Promotion
    def apply(checkout)
      checkout.line_items.each do |item|
        next unless applicable?(item)

        item.final_price = discounted_price_quantity(item.original_price, item.quantity)
      end
    end

    def applicable?(item)
      item.quantity >= 2 && super(item.product)
    end

    private

    def discounted_price_quantity(price, quantity)
      # multiply price by quantity and then subtract the price for half the quantity
      ((price * quantity) - (price * (quantity / 2))).round(2)
    end
  end
end
