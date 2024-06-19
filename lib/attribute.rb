# frozen_string_literal: true

require "#{__dir__}/change"
require "#{__dir__}/state"

# Represents an attribute of a character (e.g. bravery, fatness) that may
# permanently change over the course of a book.
class Attribute
  class << self
    def clear
      attributes.clear
    end

    def [](identifier)
      return attributes[identifier] if attributes[identifier]

      attributes[identifier] = new(identifier)
    end

    def count
      attributes.count
    end

    def attributes
      @attributes ||= {}
    end
  end

  attr_accessor :identifier

  def initialize(identifier)
    @identifier = identifier
  end

  def changes(from:, to:)
    Change.new(attribute: self, from:, to:)
  end

  def is(state_identifier)
    State[attribute: self, state_identifier:]
  end
end
