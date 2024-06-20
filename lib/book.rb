# frozen_string_literal: true

# Represents one of the books in the series.
# rubocop:todo Metrics/ClassLength
class Book
  attr_accessor :title

  def initialize(title, changes: {}, appearances: {})
    @title = title
    @changes = changes.transform_values { |character_changes|
      Array(character_changes)
    }
    @appearances = appearances.transform_values { |character_appearances|
      Array(character_appearances)
    }
  end

  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Metrics/AbcSize
  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/CyclomaticComplexity
  def must_precede?(potential_successor)
    @explanations_for_preceding ||= {}
    @explanations_for_preceding[potential_successor] = []

    potential_successor.changed_characters_with_starting_states.
      each do |character, starting_states|
        starting_states.each do |starting_state|
          attribute = starting_state[0]
          state = starting_state[1]
          next unless ends_with?(character, attribute, state)

          @explanations_for_preceding[potential_successor] <<
            "#{character.name} changes from #{state} to " \
            "#{potential_successor.changes[character].find { |c|
                 c.from == state
               }.to} in " \
            "#{potential_successor.title}, but appears as #{state} in " \
            "#{title}."
          return true
        end
      end

    changed_characters_with_ending_states.
      each do |character, ending_states|
        ending_states.each do |ending_state|
          attribute = ending_state[0]
          state = ending_state[1]

          next unless potential_successor.starts_with?(character, attribute,
                                                       state)

          @explanations_for_preceding[potential_successor] <<
            "#{character.name} changes from " \
            "#{changes[character].find { |c| c.to == state }.from} to " \
            "#{state} in #{title}, and appears as #{state} in " \
            "#{potential_successor.title}."
          return true
        end
      end
    false
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/CyclomaticComplexity

  def explanations_for_preceding(successor)
    return [] unless must_precede?(successor)
    return [] unless @explanations_for_preceding
    return [] unless @explanations_for_preceding[successor]

    @explanations_for_preceding[successor]
  end

  def changes?
    !!changes&.any?
  end

  protected

  attr_accessor :changes

  def changed_characters_with_starting_states
    result = {}
    @changes.map do |character, character_changes|
      character_changes.map do |character_change|
        result[character] ||= []
        result[character] << [character_change.attribute, character_change.from]
      end
    end
    result.to_a
  end

  def changed_characters_with_ending_states
    result = {}
    @changes.map do |character, character_changes|
      character_changes.map do |character_change|
        result[character] ||= []
        result[character] << [character_change.attribute, character_change.to]
      end
    end
    result.to_a
  end

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/CyclomaticComplexity
  def starts_with?(character, attribute, state)
    (@appearances[character] || []).each do |appearance_state|
      return true if appearance_state.attribute == attribute &&
                     appearance_state.state_identifier == state
    end
    (@changes[character] || []).each do |change|
      return true if change.attribute == attribute &&
                     change.from == state
    end
    false
  end
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/CyclomaticComplexity

  private

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/CyclomaticComplexity
  def ends_with?(character, attribute, state)
    (@appearances[character] || []).each do |appearance_state|
      return true if appearance_state.attribute == attribute &&
                     appearance_state.state_identifier == state
    end
    (@changes[character] || []).each do |change|
      return true if change.attribute == attribute &&
                     change.to == state
    end
    false
  end
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/CyclomaticComplexity
end
# rubocop:enable Metrics/ClassLength
