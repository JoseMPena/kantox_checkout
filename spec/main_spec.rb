# frozen_string_literal: true

require 'spec_helper'
require 'main'

RSpec.describe Main do
  subject { described_class.new }

  describe '#prepare' do
    it 'loads products from the fixture' do
      subject.prepare
      expect(subject.products.size).to eq(3)
      expect(subject.products.first.name).to eq('Green Tea')
    end

    it 'sets up promotions' do
      subject.prepare
      expect(subject.promotions.size).to eq(3)
      expect(subject.promotions.map(&:class))
        .to contain_exactly(Promotions::BuyOneGetOne, Promotions::BulkDiscount, Promotions::BulkDiscount)
    end

    it 'initializes a Checkout with promotions' do
      subject.prepare
      expect(subject.checkout).to be_an_instance_of(Checkout)
      expect(subject.checkout.promotions).to eq(subject.promotions)
    end
  end

  describe '#scan' do
    before { subject.prepare }

    it 'adds a valid product to the checkout' do
      product_code = 'GR1'
      expect { subject.scan(product_code) }.to change { subject.checkout.line_items.size }.by(1)
      expect(subject.checkout.line_items.first.product.code).to eq(product_code)
    end

    it 'raises an error for an invalid product code' do
      invalid_product_code = 'INVALID'
      expect { subject.scan(invalid_product_code) }
        .to raise_error(ArgumentError, "Product #{invalid_product_code} does not exist")
    end
  end

  describe 'integration tests' do
    before { subject.prepare }

    it 'calculates the total for a mixed basket' do
      subject.scan('GR1')
      subject.scan('SR1')
      subject.scan('GR1')
      subject.scan('GR1')
      subject.scan('CF1')
      expect(subject.checkout.total).to eq(22.45)
    end

    it 'calculates the total for only green teas' do
      subject.scan('GR1')
      subject.scan('GR1')
      expect(subject.checkout.total).to eq(3.11)
    end

    it 'calculates the total for strawberries and green tea' do
      subject.scan('SR1')
      subject.scan('SR1')
      subject.scan('GR1')
      subject.scan('SR1')
      expect(subject.checkout.total).to eq(16.61)
    end

    it 'calculates the total for coffee and green tea' do
      subject.scan('GR1')
      subject.scan('CF1')
      subject.scan('SR1')
      subject.scan('CF1')
      subject.scan('CF1')
      expect(subject.checkout.total).to eq(30.57)
    end
  end
end
