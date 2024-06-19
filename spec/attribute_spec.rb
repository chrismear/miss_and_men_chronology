# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/spec_helper"
require "#{File.dirname(__FILE__)}/../lib/attribute"

RSpec.describe Attribute do
  describe '.clear' do
    it 'removes all attributes' do
      described_class[:fatness]
      described_class.clear
      expect(described_class.count).to eq(0)
    end
  end

  describe '.[]' do
    context 'when the attribute has not yet been registered' do
      before do
        described_class.clear
      end

      it 'creates a new attribute' do
        expect {
          described_class[:fatness]
        }.to change(described_class, :count).by(1)
      end

      it 'returns the attribute' do
        expect(described_class[:fatness].identifier).to eq(:fatness)
      end
    end

    context 'when the attribute has already been registered' do
      before do
        described_class.clear
        described_class[:fatness]
      end

      it 'does not create a new attribute' do
        expect {
          described_class[:fatness]
        }.not_to change(described_class, :count)
      end

      it 'returns the attribute' do
        expect(described_class[:fatness].identifier).to eq(:fatness)
      end
    end
  end

  describe '#changes' do
    it 'returns a Change' do
      expect(described_class[:fatness].changes(from: :fat,
                                               to: :thin)).to be_a(Change)
    end
  end

  describe '#is' do
    it 'returns a State' do
      expect(described_class[:fatness].is(:fat)).to be_a(State)
    end
  end
end
