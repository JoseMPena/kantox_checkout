# frozen_string_literal: true

require 'promotion'
require_relative '../mixins/price_discountable'

module Promotions
  # Applies promotion rules to add a free item for each applicable product in the checkout
  class BuyOneGetOne < ::Promotion
    include PriceDiscountable

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
