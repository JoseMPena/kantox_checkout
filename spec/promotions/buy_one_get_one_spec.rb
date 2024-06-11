# frozen_string_literal: true

require 'rspec'
require 'line_item'
require 'promotions/buy_one_get_one'

describe Promotions::BuyOneGetOne do
  let(:items) { load_fixture('line_items') }
  let(:item1) { LineItem.new(**items.first) }
  let(:item2) { LineItem.new(**items.last) }
  let(:checkout) { double('Checkout', line_items: [item1, item2]) }
  let(:promo) { described_class.new([item1.product['code']]) }

  describe '#apply' do
    context 'when line_items have insufficient quantity' do
      it 'does not modify the price' do
        expect { promo.apply(checkout) }.to_not(change { item1.final_price })
      end
    end

    context 'when line_items have a promotable quantity' do
      let(:item1) { LineItem.new(items.first.merge('quantity' => 3)) }
      let(:item2) { LineItem.new(items.last.merge('quantity' => 3)) }

      it 'adjusts the item prices to meet buy-one-get-one rule' do
        expect { promo.apply(checkout) }
          .to change { item1.final_price }.to(item1.original_price * 2)
      end

      it 'does not adjust non-applicable products' do
        expect { promo.apply(checkout) }.to_not(change { item2.final_price })
      end
    end
  end
end
