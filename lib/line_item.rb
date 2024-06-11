# frozen_string_literal: true

# Represents a product belonging to a checkout
class LineItem
  attr_reader :product, :original_price
  attr_accessor :quantity, :final_price

  def initialize(attrs)
    @product = attrs["product"]
    @original_price = attrs["product"]["price"]
    @quantity = attrs["quantity"]
    @final_price = @original_price * attrs["quantity"]
  end
end
