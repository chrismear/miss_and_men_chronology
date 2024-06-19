# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/book_set'
require_relative '../lib/book'

RSpec.describe BookSet do
  let(:greedy) { Book.new('Mr Greedy') }
  let(:busy) { Book.new('Little Miss Busy') }
  let(:funny) { Book.new('Mr Funny') }
  let(:sunshine) { Book.new('Little Miss Sunshine') }

  describe '.construct' do
    it 'creates a new BookSet' do
      book_set = described_class.construct { |set|
        set.add(greedy)
        set.add(busy, must_precede: greedy)
      }
      expect(book_set.books).to eq([greedy, busy])
    end
  end

  describe '#add' do
    let(:book_set) { described_class.new }

    it 'adds a book to the set' do
      book_set.add(greedy)
      expect(book_set.books).to eq([greedy])
    end

    it 'adds a book that must precede another book' do
      book_set.add(greedy)
      book_set.add(busy, must_precede: greedy)
      expect(book_set[busy].precedes?(greedy)).to be true
    end
  end

  describe '#books' do
    it 'returns the books in the set, in no particular order' do
      book_set = described_class.construct do |set| # rubocop:disable Style/BlockDelimiters
        set.add(greedy)
        set.add(busy, must_precede: greedy)
      end
      expect(book_set.books).to contain_exactly(greedy, busy)
    end
  end

  describe '#disconnected_graphs' do
    let(:set) {
      described_class.construct do |set|
        set.add(greedy)
        set.add(busy, must_precede: greedy)
        set.add(funny)
        set.add(sunshine)
      end
    }

    it 'splits the graph into disconnected subgraphs' do
      expect(set.disconnected_graphs.map(&:books)).to eq([
                                                           [greedy, busy],
                                                           [funny],
                                                           [sunshine]
                                                         ])
    end
  end
end
