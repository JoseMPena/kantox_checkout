# frozen_string_literal: true

# Represents a product belonging to a checkout
class LineItem
  attr_reader :product, :original_price
  attr_accessor :quantity, :total_price

  def initialize(product, quantity = 1)
    @product = product
    @quantity = quantity
    calculate_total_price
  end

  def update_quantity(new_quantity)
    @quantity = new_quantity
    calculate_total_price
  end

  private

  def calculate_total_price
    @total_price = @product.price * @quantity
  end
end
