# frozen_string_literal: true

require 'rspec'
require 'promotion'

describe Promotion do
  let(:products) { load_fixture('products') }
  let(:product1) { products.first }
  let(:product2) { products.last }
  let(:promotion) { described_class.new([product1["code"], product2["code"]]) }

  describe 'accessors' do
    it 'holds and returns promotable products' do
      expect(promotion.promotable_products).to eq([product1["code"], product2["code"]])
    end
  end

  describe '#apply' do
    it 'raises a NotImplementedError' do
      expect { promotion.apply({}) }.to raise_error(NotImplementedError)
    end
  end

  describe '#applicable?' do
    context 'when a product is added as promotable product' do
      let(:promotion) { described_class.new([product1["code"], product2["code"]]) }

      it { expect(promotion.applicable?(product1)).to be true }
    end

    context 'when it has promotable products but not the one requested' do
      let(:promotion) { described_class.new([product1["code"]]) }

      it { expect(promotion.applicable?(product2)).to be false }
    end

    context 'when it has no promotable products' do
      let(:promotion) { described_class.new([]) }

      it { expect(promotion.applicable?(product1)).to be false }
      it { expect(promotion.applicable?(product2)).to be false }
    end
  end
end
