# frozen_string_literal: true

require 'spec_helper'
require 'product'

describe Product do
  let(:product_attrs) { load_fixture('products')[0] }
  subject { described_class.new(**product_attrs) }

  context 'accessors' do
    it { expect(subject.name).to eq('Green Tea') }
    it { expect(subject.code).to eq('GR1') }
    it { expect(subject.price).to eq(3.11) }
  end
end
