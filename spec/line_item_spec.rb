# frozen_string_literal: true

require 'spec_helper'
require 'line_item'

RSpec.describe LineItem do
  let(:product) { Product.new(**load_fixture('products')[0]) }
  subject { described_class.new(product, 2) }

  it 'initializes with a product and quantity' do
    expect(subject.product).to eq(product)
    expect(subject.quantity).to eq(2)
  end

  it 'calculates the total price' do
    expect(subject.total_price).to eq(6.22)
  end

  it 'updates the quantity and recalculates the total price' do
    subject.update_quantity(3)
    expect(subject.quantity).to eq(3)
    expect(subject.total_price).to eq(9.33)
  end
end
