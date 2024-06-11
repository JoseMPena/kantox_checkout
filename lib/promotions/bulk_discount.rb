# frozen_string_literal: true

require 'bigdecimal'
require 'promotion'
require_relative '../mixins/price_discountable'

module Promotions
  # Applies 0,50 discount when buying 3 or more of a product
  class BulkDiscount < Promotion
    include PriceDiscountable

    DISCOUNTED_AMOUNT = 0.50
    BULK_QUANTITY = 3

    attr_reader :discounted_amount

    def initialize(promotable, discount = DISCOUNTED_AMOUNT)
      super(promotable)
      @discounted_amount = discount
    end

    def applicable?(item)
      super(item.product) && item.quantity >= BULK_QUANTITY
    end

    private

    def discounted_price_quantity(price, quantity)
      discounted_unit_price = BigDecimal((price - discounted_amount).to_s)
      (discounted_unit_price * quantity).round(2).to_f
    end
  end
end
