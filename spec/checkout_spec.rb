# frozen_string_literal: true

require 'spec_helper'
require 'checkout'
require 'product'
require 'promotions/buy_one_get_one'
require 'promotions/bulk_discount'

RSpec.describe Checkout do
  let(:product_attributes) { load_fixture('products') }
  let(:green_tea) { Product.new(product_attributes[0]) }
  let(:strawberries) { Product.new(product_attributes[1]) }
  let(:coffee) { Product.new(product_attributes[2]) }

  let(:bogo_tea) { Promotions::BuyOneGetOne.new(['GR1']) }
  let(:bulk_strawberries) { Promotions::BulkDiscount.new(['SR1'], 3, 4.50) }
  let(:bulk_coffee) { Promotions::BulkDiscount.new(['CF1'], 3, coffee.price * (2 / 3.0)) }
  let(:pricing_rules) { [bogo_tea, bulk_strawberries, bulk_coffee] }

  subject { described_class.new(pricing_rules) }

  describe '#scan' do
    it 'adds a product as a line item' do
      subject.scan(green_tea)
      expect(subject.line_items.size).to eq(1)
      expect(subject.line_items.first.product).to eq(green_tea)
      expect(subject.line_items.first.quantity).to eq(1)
    end

    it 'increments the quantity for existing line items' do
      2.times { subject.scan(green_tea) }
      expect(subject.line_items.size).to eq(1)
      expect(subject.line_items.first.quantity).to eq(2)
    end
  end

  describe '#total' do
    it 'calculates the total without promotions' do
      subject.scan(green_tea)
      subject.scan(strawberries)
      expect(subject.total).to eq(8.11)
    end

    it 'applies buy-one-get-one-free promotion for green tea' do
      2.times { subject.scan(green_tea) }
      expect(subject.total).to eq(3.11)
    end

    it 'applies bulk discount for strawberries' do
      3.times { subject.scan(strawberries) }
      expect(subject.total).to eq(13.50)
    end

    it 'applies bulk discount for coffee' do
      3.times { subject.scan(coffee) }
      expect(subject.total).to eq(22.46)
    end

    it 'calculates the correct total with mixed products and promotions' do
      subject.scan(green_tea)
      subject.scan(strawberries)
      subject.scan(green_tea)
      subject.scan(green_tea)
      subject.scan(coffee)
      expect(subject.total).to eq(22.45)
    end
  end
end
