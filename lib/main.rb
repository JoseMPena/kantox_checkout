# frozen_string_literal: true

require_relative './product'
require_relative './checkout'
require_relative './line_item'
require_relative './promotions/buy_one_get_one'
require_relative './promotions/bulk_discount'
require_relative './helpers/fixture_helper'

# Application's entry point
class Main
  include FixtureHelper
  attr_reader :products, :promotions, :checkout

  def prepare
    prepare_products
    prepare_promotions
    @checkout = Checkout.new(@promotions)
  end

  def scan(product_code)
    product = @products.find { |p| p.code == product_code }
    raise ArgumentError, "Product #{product_code} does not exist" unless product

    @checkout.scan(product)
  end

  private

  def prepare_products
    @products = load_fixture('products').map do |product_attrs|
      Product.new(product_attrs)
    end
  end

  def prepare_promotions
    @promotions = [
      Promotions::BuyOneGetOne.new(product_codes: ['GR1']),
      Promotions::BulkDiscount.new(product_codes: ['SR1'], min_quantity: 3, discount_price: 4.50),
      Promotions::BulkDiscount.new(product_codes: ['CF1'], min_quantity: 3, discount_price: 11.23 * (2 / 3.0))
    ]
  end
end
