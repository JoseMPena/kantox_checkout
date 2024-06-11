# frozen_string_literal: true

require 'rspec'
require 'line_item'
require 'promotions/bulk_discount'

describe Promotions::BulkDiscount do
  # TODO: maybe refactor to shared examples
  let(:item_attributes) { load_fixture('line_items').first }
  let(:item) { LineItem.new(item_attributes.merge('quantity' => 3)) }
  let(:promo) { described_class.new([item.product['code']]) }

  describe '#applicable?' do
    context 'when line_items quantity is < 3' do
      let(:item) { LineItem.new(item_attributes) }
      it { expect(promo.applicable?(item)).to be false }
    end

    context 'when line_items quantity is 3' do
      it { expect(promo.applicable?(item)).to be true }
    end

    context 'when line_items quantity is > 3' do
      let(:item) { LineItem.new(item_attributes.merge('quantity' => 5)) }

      it { expect(promo.applicable?(item)).to be true }
    end

    context 'when line_item code is not promotable' do
      let(:promo) { described_class.new(['other']) }

      it { expect(promo.applicable?(item)).to be false }
    end
  end

  describe '#apply' do
    let(:checkout) { instance_double('Checkout', line_items: [item]) }

    context 'when it is applicable' do
      it 'adjusts the price with a discount of 0,50' do
        expect { promo.apply(checkout) }.to change(item, :final_price).to(13.50)
      end
    end

    context 'when is not applicable' do
      let(:promo) { described_class.new(['other']) }

      it 'does not adjust the price with discounts' do
        expect { promo.apply(checkout) }.to_not change(item, :final_price)
      end
    end
  end
end
