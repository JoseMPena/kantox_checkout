# frozen_string_literal: true

require 'rspec'
require 'line_item'
require 'promotions/bulk_discount'

describe Promotions::BulkDiscount do
  let(:item_attributes) { load_fixture('line_items').first }
  let(:item) { LineItem.new(item_attributes.merge('quantity' => 3)) }
  let(:promo) { described_class.new([item.product['code']]) }

  it_behaves_like 'a bulk promotion'

  describe '#apply' do
    let(:checkout) { instance_double('Checkout', line_items: [item]) }

    context 'when it is applicable' do
      it 'adjusts the price with a discount of 0,50' do
        expect { promo.apply(checkout) }.to change(item, :final_price).to(13.50)
      end
    end
  end
end
