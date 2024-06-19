# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../lib/ordering"
require "#{File.dirname(__FILE__)}/../lib/book"
require "#{File.dirname(__FILE__)}/../lib/character"
require "#{File.dirname(__FILE__)}/../lib/attribute"

RSpec.describe Ordering do
  context 'when there is just one book' do
    let(:books) {
      [
        Book.new(
          'Mr Greedy',
          characters: Character['Mr Greedy'],
          changes: {
            Character['Mr Greedy'] =>
              Attribute[:fatness].changes(from: :fat, to: :thin)
          }
        )
      ]
    }

    it 'returns just the one book' do
      expect(described_class.new(books).order.first.map(&:title)).
        to eq(['Mr Greedy'])
    end
  end

  context 'when there are two books with one character change' do
    let(:greedy) {
      Book.new(
        'Mr Greedy',
        characters: Character['Mr Greedy'],
        changes: {
          Character['Mr Greedy'] =>
            Attribute[:fatness].changes(from: :fat, to: :thin)
        }
      )
    }
    let(:busy) {
      Book.new(
        'Little Miss Busy',
        characters: Character['Mr Greedy'],
        appearances: {
          Character['Mr Greedy'] => Attribute[:fatness].is(:fat)
        }
      )
    }
    let(:books) {
      [greedy, busy]
    }

    it 'correctly deduces the order' do
      set = described_class.new(books).order.first
      expect(set[busy].precedes?(greedy)).to be true
    end

    it 'explains the ordering' do
      expect(described_class.new(books).explanations).to include(
        'Little Miss Busy must happen before Mr Greedy because Mr Greedy ' \
        'changes from fat to thin in Mr Greedy, but appears as fat in ' \
        'Little Miss Busy.'
      )
    end
  end
end
