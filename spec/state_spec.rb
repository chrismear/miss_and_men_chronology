# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/spec_helper"
require "#{File.dirname(__FILE__)}/../lib/state"
require_relative '../lib/attribute'

RSpec.describe State do
  describe '.clear' do
    it 'removes all states' do
      fatness = Attribute[:fatness]
      described_class[attribute: fatness, state_identifier: :fat]
      described_class.clear
      expect(described_class.count).to eq(0)
    end
  end

  describe '.[]' do
    let(:attribute) { Attribute[:fatness] }

    context 'when the state has not yet been registered' do
      before do
        described_class.clear
      end

      it 'creates a new state' do
        expect {
          described_class[attribute:,
                          state_identifier: :fat]
        }.to change(described_class, :count).by(1)
      end

      it 'returns the state' do
        expect(
          described_class[attribute:, state_identifier: :fat].state_identifier
        ).to eq(:fat)
      end
    end

    context 'when the state has already been registered' do
      before do
        described_class.clear
        described_class[attribute:, state_identifier: :fat]
      end

      it 'does not create a new state' do
        expect {
          described_class[attribute:,
                          state_identifier: :fat]
        }.not_to change(described_class, :count)
      end

      it 'returns the state' do
        expect(
          described_class[attribute:, state_identifier: :fat].state_identifier
        ).to eq(:fat)
      end
    end
  end
end
