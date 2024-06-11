# frozen_string_literal: true

require 'bigdecimal'
require 'promotion'
require_relative '../mixins/price_discountable'
require_relative '../mixins/bulk_promotable'

module Promotions
  # Adjusts the price to a given fraction on applicable items
  class BulkPriceDrop < Promotion
    include PriceDiscountable
    include BulkPromotable

    PRICE_DROP_FRACTION = '2/3'

    attr_reader :discount_fraction

    def initialize(promotable, discount = PRICE_DROP_FRACTION)
      super(promotable)
      @discount_fraction = discount.to_r
    end

    private

    def discounted_price_quantity(price, quantity)
      discounted_unit_price = price * discount_fraction
      (discounted_unit_price * quantity).round(2)
    end
  end
end
