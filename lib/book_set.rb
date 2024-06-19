# frozen_string_literal: true

# Represents an set of books in either a directed or cyclic graph.
# rubocop:todo Metrics/ClassLength
class BookSet
  class << self
    def construct(&)
      new.tap(&)
    end
  end

  def initialize(graph: {}, explanations: {})
    # Adjacency list representation of a directed graph, possibly cyclic.
    @graph = graph

    @explanations = explanations
  end

  def add(book, must_precede: [], explanations: [])
    must_precede = Array(must_precede)
    explanations = Array(explanations)

    must_precede.each do |successor|
      @graph[successor] ||= []

      store_explanations(book, successor, explanations)
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
      self.class.new(graph: new_graph, explanations:)
    }
  end

  # Returns true if `book` precedes `other` in the graph.
  def precedes?(book, other)
    return false unless @graph.key?(book)

    return true if @graph[book].include?(other)

    @graph[book].any? { |destination| precedes?(destination, other) }
  end

  def inspect
    result = ''.dup
    @graph.each do |book, destinations|
      result << "#{book.title} -> #{destinations.map(&:title).join(', ')}\n"
    end
    result << flat_order.map(&:title).join(' -> ')
    result
  end

  # Collapses a graph into a flat list that retains the correct ordering.
  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Metrics/AbcSize
  def flat_order
    depth_first_search = lambda do |vertex, visited, stack|
      visited[vertex] = true
      @graph[vertex].each do |destination|
        unless visited[destination]
          depth_first_search.call(destination, visited,
                                  stack)
        end
      end
      stack << vertex
    end

    stack = []
    visited = Hash.new(false)
    @graph.each_key do |vertex|
      depth_first_search.call(vertex, visited, stack) unless visited[vertex]
    end

    sorted = []
    sorted << stack.pop until stack.empty?
    sorted
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  # Returns true if there is a cycle in the graph.
  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Metrics/AbcSize
  def cycle?
    depth_first_search = lambda do |vertex, visited, stack|
      visited[vertex] = true
      stack[vertex] = true
      @graph[vertex].each do |destination|
        return true if stack[destination]
        next if visited[destination]

        return true if depth_first_search.call(destination, visited, stack)
      end
      stack[vertex] = false
      false
    end

    visited = Hash.new(false)
    stack = Hash.new(false)
    @graph.each_key do |vertex|
      return true if depth_first_search.call(vertex, visited, stack)
    end
    false
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  # Returns an array of cycles, with each cycle being the minimal ordered set of
  # books that form a cycle.
  def cycles
    cycles = []
    visited = {}
    @graph.each_key do |vertex|
      next if visited.key?(vertex)

      cycle = find_cycle(vertex, visited)
      cycles << cycle if cycle
    end
    cycles
  end

  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Metrics/AbcSize
  def to_image(graph)
    nodes_by_book = {}
    @graph.each do |book, destinations|
      nodes_by_book[book] ||= graph.add_nodes(book.title)
      destinations.each do |destination|
        nodes_by_book[destination] ||= graph.add_nodes(destination.title)
        explanation = (explanations.dig(book, destination) || []).join(' and ')
        if explanation.empty?
          graph.add_edge(nodes_by_book[book], nodes_by_book[destination])
        else
          graph.add_edge(nodes_by_book[book], nodes_by_book[destination],
                         label: explanation)
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  # rubocop:todo Metrics/MethodLength
  def find_cycle(vertex, visited, stack = [])
    return nil if visited[vertex]

    visited[vertex] = true
    stack << vertex
    @graph[vertex].each do |destination|
      if stack.include?(destination)
        start = stack.index(destination)
        return stack[start..]
      end

      cycle = find_cycle(destination, visited, stack)
      return cycle if cycle
    end
    stack.pop
    nil
  end
  # rubocop:enable Metrics/MethodLength

  def store_explanations(book, successor, new_explanations)
    @explanations ||= {}
    @explanations[book] ||= {}
    @explanations[book][successor] ||= []
    @explanations[book][successor].concat(new_explanations)
  end

  def explanations
    @explanations ||= {}
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
# rubocop:enable Metrics/ClassLength
