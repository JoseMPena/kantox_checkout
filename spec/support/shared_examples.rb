# frozen_string_literal: true

RSpec.shared_examples 'a bulk promotion' do
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

  describe '#apply?' do
    let(:checkout) { instance_double('Checkout', line_items: [item]) }

    context 'when is not applicable' do
      let(:promo) { described_class.new(['other']) }

      it 'does not adjust the price with discounts' do
        expect { promo.apply(checkout) }.to_not change(item, :final_price)
      end
    end
  end
end
