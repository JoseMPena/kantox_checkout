# frozen_string_literal: true

require 'rspec'
require 'product'

describe Product do
  let(:product_attrs) { load_fixture('products')[0] }
  subject { described_class.new(**product_attrs) }

  context 'accessors' do
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:price) }
  end
end
