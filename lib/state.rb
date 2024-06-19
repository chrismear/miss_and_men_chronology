# frozen_string_literal: true

# Represents one of the states that an Attribute can be in; for example, the
# Attribute "bravery" might have states "cowardly" and "brave".
class State
  class << self
    def [](attribute:, state_identifier:)
      if states.dig(attribute, state_identifier)
        return states.dig(attribute, state_identifier)
      end

      states[attribute] ||= {}
      states[attribute][state_identifier] = new(attribute:, state_identifier:)
    end

    def states
      @states ||= {}
    end

    def clear
      @states = {}
    end

    def count
      states.count
    end
  end

  attr_accessor :attribute, :state_identifier

  def initialize(attribute:, state_identifier:)
    @attribute = attribute
    @state_identifier = state_identifier
  end
end
