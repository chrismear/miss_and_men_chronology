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

    it 'outputs a graph image' do
      expect { described_class.new(books).to_image }.not_to raise_error
    end
  end

  context 'when there are two books with one character change' do
    let(:greedy) {
      Book.new(
        'Mr Greedy',
        changes: {
          Character['Mr Greedy'] =>
            Attribute[:fatness].changes(from: :fat, to: :thin)
        }
      )
    }
    let(:busy) {
      Book.new(
        'Little Miss Busy',
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
        'Mr Greedy ' \
        'changes from fat to thin in Mr Greedy, but appears as fat in ' \
        'Little Miss Busy.'
      )
    end

    it 'outputs a graph image' do
      expect { described_class.new(books).to_image }.not_to raise_error
    end
  end

  context 'when a character appears in another book after their change' do
    let(:books) {
      [
        Book.new(
          'Mr Greedy',
          changes: {
            Character['Mr Greedy'] =>
              Attribute[:fatness].changes(from: :fat, to: :thin)
          }
        ),
        Book.new(
          'Imaginary Book',
          appearances: {
            Character['Mr Greedy'] => Attribute[:fatness].is(:thin)
          }
        )
      ]
    }

    it 'finds the order' do
      expect(described_class.new(books).order.first.flat_order.map(&:title)).
        to eq(['Mr Greedy', 'Imaginary Book'])
    end
  end

  context 'when there is a complex, multi-graph ordering that is non-cyclic' do
    let(:greedy) {
      Book.new(
        'Mr Greedy',
        changes: {
          Character['Mr Greedy'] =>
            Attribute[:fatness].changes(from: :fat, to: :thin)
        }
      )
    }
    let(:busy) {
      Book.new(
        'Little Miss Busy',
        appearances: {
          Character['Mr Greedy'] => Attribute[:fatness].is(:fat)
        }
      )
    }
    let(:nosy) {
      Book.new(
        'Mr Nosey',
        changes: {
          Character['Mr Nosey'] =>
            Attribute[:nosiness].changes(from: :nosy, to: :not_nosy)
        }
      )
    }
    let(:twins) {
      Book.new(
        'Little Miss Twins',
        appearances: {
          Character['Mr Nosey'] => Attribute[:nosiness].is(:nosy)
        }
      )
    }
    let(:nosy_two) {
      Book.new(
        'Mr Nosey Part Two',
        appearances: {
          Character['Mr Nosey'] => Attribute[:nosiness].is(:nosy)
        }
      )
    }

    it 'finds two separate graphs' do
      expect(described_class.new([greedy, busy, nosy, twins,
                                  nosy_two]).order.size).to eq(2)
    end

    it 'finds no cycles' do
      expect(
        described_class.new([greedy, busy, nosy, twins, nosy_two]).
          order.all? { |set| !set.cycle? }
      ).to be true
    end

    it 'outputs a graph image' do
      expect {
        described_class.new([greedy, busy, nosy, twins,
                             nosy_two]).to_image
      }.not_to raise_error
    end
  end

  context 'when there is a cyclic graph' do
    let(:book_one) {
      Book.new('One',
               changes: {
                 Character['Mr Man'] =>
                 Attribute[:weirdness].changes(
                   from: :not_weird, to: :slightly_weird
                 )
               })
    }
    let(:book_two) {
      Book.new('Two',
               changes: {
                 Character['Mr Man'] =>
                 Attribute[:weirdness].changes(
                   from: :slightly_weird, to: :very_weird
                 )
               })
    }
    let(:book_three) {
      Book.new('Three',
               changes: {
                 Character['Mr Man'] =>
                 Attribute[:weirdness].changes(
                   from: :very_weird, to: :not_weird
                 )
               })
    }

    let(:books) { [book_one, book_two, book_three] }

    it 'finds the cycle' do
      expect(described_class.new(books).order.first.cycle?).to be true
    end

    it 'outputs a graph image' do
      expect { described_class.new(books).to_image }.not_to raise_error
    end
  end
end
