# frozen_string_literal: true

require_relative 'lib/book'
require_relative 'lib/character'
require_relative 'lib/attribute'
require_relative 'lib/ordering'

books = []

books.push Book.new(
  'Mr Greedy',
  changes: {
    Character['Mr Greedy'] => Attribute[:fatness].changes(from: :fat, to: :thin)
  }
)
books.push Book.new(
  'Little Miss Busy',
  appearances: { Character['Mr Greedy'] => Attribute[:fatness].is(:thin) }
)
books.push Book.new(
  'Mr Nosy',
  changes: {
    Character['Mr Nosy'] =>
      Attribute[:nosiness].changes(from: :nosy, to: :not_nosy)
  }
)
books.push Book.new(
  'Little Miss Twins',
  appearances: { Character['Mr Nosy'] => Attribute[:nosiness].is(:nosy) }
)
books.push Book.new(
  'Mr Chatterbox',
  changes: {
    Character['Mr Chatterbox'] =>
      Attribute[:chattiness].changes(from: :chatty, to: :quiet)
  }
)

Ordering.new(books).to_image('little-miss-and-mr-men-ordering')
