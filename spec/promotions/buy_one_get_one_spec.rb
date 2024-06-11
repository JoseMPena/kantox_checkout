# frozen_string_literal: true

require 'spec_helper'
require 'line_item'
require 'promotions/buy_one_get_one'

describe Promotions::BuyOneGetOne do
  let(:product) { Product.new(**load_fixture('products')[0]) }
  let(:line_item) { LineItem.new(product, 3) }
  let(:checkout) { instance_double('Checkout', line_items: [line_item]) }
  subject { described_class.new(product_codes: ['GR1']) }

  it 'applies the promotion to eligible products' do
    subject.apply(checkout)
    expect(line_item.total_price).to eq(6.22)
  end

  it 'does not apply the promotion to ineligible products' do
    other_product = Product.new(**load_fixture('products')[1])
    other_line_item = LineItem.new(other_product, 2)
    checkout = instance_double('Checkout', line_items: [other_line_item])

    subject.apply(checkout)
    expect(other_line_item.total_price).to eq(10.00)
  end
end
