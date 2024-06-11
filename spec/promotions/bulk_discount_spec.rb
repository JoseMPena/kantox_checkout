# frozen_string_literal: true

require 'spec_helper'
require 'line_item'
require 'promotions/bulk_discount'

describe Promotions::BulkDiscount do
  let(:product) { Product.new(**load_fixture('products')[1]) }
  let(:line_item) { LineItem.new(product, 4) }
  let(:checkout) { instance_double('Checkout', line_items: [line_item]) }
  subject { described_class.new(product_codes: ['SR1'], min_quantity: 3, discount_price: 4.50) }

  it 'applies the discount to eligible products' do
    subject.apply(checkout)
    expect(line_item.total_price).to eq(18.00)
  end

  it 'does not apply the discount to ineligible quantities' do
    line_item.update_quantity(2)
    subject.apply(checkout)
    expect(line_item.total_price).to eq(10.00)
  end
end
