# frozen_string_literal: true

# Represents an set of books in either a directed or cyclic graph.
class BookSet
  class << self
    def construct(&)
      new.tap(&)
    end
  end

  def initialize(graph: {})
    # Adjacency list representation of a directed graph, possibly cyclic.
    @graph = graph
  end

  def add(book, must_precede: [])
    must_precede = Array(must_precede)

    must_precede.each do |successor|
      @graph[successor] ||= []
    end

    @graph[book] ||= []
    @graph[book].concat(must_precede)

    book
  end

  def books
    @graph.keys
  end

  def [](book)
    return nil unless @graph.key?(book)

    BookProxy.new(book, self)
  end

  def map(&)
    @graph.keys.map(&)
  end

  # rubocop:todo Metrics/MethodLength
  def disconnected_graphs
    subgroups = []
    visited = {}
    @graph.each do |book, destinations|
      next if visited.key?(book)

      connected_books = [book] + destinations
      existing_subgroup = subgroups.find { |subgroup|
        (subgroup & connected_books).any?
      }
      if existing_subgroup
        existing_subgroup.concat(connected_books).uniq!
      else
        subgroups << connected_books
      end
    end
    subgraphs_from_subgroups(subgroups)
  end
  # rubocop:enable Metrics/MethodLength

  def subgraphs_from_subgroups(subgroups)
    subgroups.map { |books|
      new_graph = @graph.select { |book, _destinations| books.include?(book) }
      self.class.new(graph: new_graph)
    }
  end

  # Returns true if `book` precedes `other` in the graph.
  def precedes?(book, other)
    return false unless @graph.key?(book)

    return true if @graph[book].include?(other)

    @graph[book].any? { |destination| precedes?(destination, other) }
  end

  # Thin wrapper around a Book in a BookSet to add helper methods relating to
  # its position in the graph.
  class BookProxy
    def initialize(book, book_set)
      @book = book
      @set = book_set
    end

    def precedes?(other)
      @set.precedes?(book, other)
    end

    private

    attr_accessor :book
  end
end
