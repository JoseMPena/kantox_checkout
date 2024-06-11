# frozen_string_literal: true

require_relative 'line_item'

# Abstracts the checkout functionality
class Checkout
  attr_accessor :promotions, :line_items

  def initialize(pricing_rules)
    @promotions = pricing_rules
    @line_items = []
  end

  def scan(product)
    line_item = find_line_item(product)

    if line_item
      line_item.update_quantity(line_item.quantity + 1)
    else
      @line_items << LineItem.new(product)
    end

    apply_promotions
  end

  def total
    line_items.sum(&:total_price).round(2)
  end

  private

  def find_line_item(product)
    line_items.find { |item| item.product.code == product.code }
  end

  def apply_promotions
    promotions.each { |rule| rule.apply(self) }
  end
end
