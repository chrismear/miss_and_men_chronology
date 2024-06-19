# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/spec_helper"
require "#{File.dirname(__FILE__)}/../lib/character"

RSpec.describe Character do
  describe '.clear' do
    it 'removes all characters' do
      described_class['Mr Greedy']
      described_class.clear
      expect(described_class.count).to eq(0)
    end
  end

  describe '.[]' do
    context 'when the character has not yet been registered' do
      before do
        described_class.clear
      end

      it 'creates a new character' do
        expect {
          described_class['Mr Greedy']
        }.to change(described_class, :count).by(1)
      end

      it 'returns the character' do
        expect(described_class['Mr Greedy'].name).to eq('Mr Greedy')
      end
    end

    context 'when the character has already been registered' do
      before do
        described_class.clear
        described_class['Mr Greedy']
      end

      it 'does not create a new character' do
        expect {
          described_class['Mr Greedy']
        }.not_to change(described_class, :count)
      end

      it 'returns the character' do
        expect(described_class['Mr Greedy'].name).to eq('Mr Greedy')
      end
    end
  end
end
