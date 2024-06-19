# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/book'
require_relative '../lib/character'
require_relative '../lib/attribute'

RSpec.describe Book do
  let(:book_with_one_change) {
    described_class.new(
      'Example book',
      characters: Character['Example character'],
      changes: {
        Character['Example character'] =>
          Attribute[:example_attribute].changes(from: :start, to: :finish)
      }
    )
  }
  let(:book_with_multiple_changes) {
    described_class.new(
      'Example book',
      characters: Character['Example character'],
      changes: {
        Character['Example character'] =>
          Attribute[:example_attribute].changes(from: :start, to: :finish),
        Character['Example character'] =>
          Attribute[:another_attribute].changes(from: :beginning, to: :end)
      }
    )
  }
  let(:book_with_no_changes) {
    described_class.new(
      'Example book',
      characters: [Character['Example character'],
                   Character['Another character']]
    )
  }
  let(:book_with_no_characters) {
    described_class.new(
      'Example book'
    )
  }
  let(:book_with_multiple_characters_changing) {
    described_class.new(
      'Example book',
      characters: [Character['Example character'],
                   Character['Another character'],
                   Character['Unchanged character']],
      changes: {
        Character['Example character'] =>
          Attribute[:example_attribute].changes(from: :start, to: :finish),
        Character['Example character'] =>
          Attribute[:yet_another_attribute].changes(from: :something,
                                                    to: :else),
        Character['Another character'] =>
          Attribute[:another_attribute].changes(from: :beginning, to: :end)
      },
      appearances: {
        Character['Unchanged character'] =>
          Attribute[:unchanged_attribute].is(:unchanged)
      }
    )
  }

  describe '.changes?' do
    it 'returns true if a character experiences one change in the book' do
      expect(book_with_one_change.changes?).to be true
    end

    it 'returns true if a character experiences multiple changes in the book' do
      expect(book_with_multiple_changes.changes?).to be true
    end

    it 'returns true if multiple characters experience changes in the book' do
      expect(book_with_multiple_characters_changing.changes?).to be true
    end

    it 'returns false if no characters experience changes' do
      expect(book_with_no_changes.changes?).to be false
    end

    it 'returns false if there are no characters' do
      expect(book_with_no_characters.changes?).to be false
    end
  end
end
