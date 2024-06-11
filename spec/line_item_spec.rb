require 'rspec'
require_relative '../lib/line_item'

RSpec.describe LineItem do
  let(:product) { load_fixture('products')[0] }
  let(:quantity) { 3 }
  let(:attrs) { { "product" => product, "quantity" => quantity } }

  describe '#initialize' do
    it 'sets the product correctly' do
      line_item = LineItem.new(attrs)
      expect(line_item.product).to eq(product)
    end

    it 'sets the original price correctly' do
      line_item = LineItem.new(attrs)
      expect(line_item.original_price).to eq(3.11)
    end

    it 'sets the quantity correctly' do
      line_item = LineItem.new(attrs)
      expect(line_item.quantity).to eq(quantity)
    end

    it 'calculates the final price correctly' do
      line_item = LineItem.new(attrs)
      expect(line_item.final_price).to eq(9.33)
    end
  end

  describe 'attributes' do
    it 'allows reading and writing for :quantity' do
      line_item = LineItem.new(attrs)
      line_item.quantity = 5
      expect(line_item.quantity).to eq(5)
    end

    it 'allows reading and writing for :final_price' do
      line_item = LineItem.new(attrs)
      line_item.final_price = 12.34
      expect(line_item.final_price).to eq(12.34)
    end
  end
end
