# frozen_string_literal: true

require 'bigdecimal'
require 'promotion'
require_relative '../mixins/price_discountable'
require_relative '../mixins/bulk_promotable'

module Promotions
  # Applies 0,50 discount when buying 3 or more of a product
  class BulkDiscount < Promotion
    include PriceDiscountable
    include BulkPromotable
    attr_reader :discounted_amount

    DISCOUNTED_AMOUNT = 0.50

    def initialize(promotable, discount = DISCOUNTED_AMOUNT)
      super(promotable)
      @discounted_amount = discount
    end

    private

    def discounted_price_quantity(price, quantity)
      discounted_unit_price = BigDecimal((price - discounted_amount).to_s)
      (discounted_unit_price * quantity).round(2).to_f
    end
  end
end
