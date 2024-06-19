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

Ordering.new(books).to_image('mr-men-and-little-miss-ordering')
