# frozen_string_literal: true

# Represent an Attribute of a Character changing from one state to another.
class Change
  attr_accessor :attribute, :from, :to

  def initialize(attribute:, from:, to:)
    @attribute = attribute
    @from = from
    @to = to
  end
end
