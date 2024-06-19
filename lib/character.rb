# frozen_string_literal: true

# Represents a character in the books.
class Character
  class << self
    def clear
      characters.clear
    end

    def [](name)
      return characters[name] if characters[name]

      characters[name] = new(name)
    end

    def count
      characters.count
    end

    def characters
      @characters ||= {}
    end
  end

  attr_accessor :name

  def initialize(name)
    @name = name
  end
end
