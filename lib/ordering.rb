# frozen_string_literal: true

require_relative 'book_set'
require 'graphviz'
require 'time'

# Calculates the chronological order of the books in the series.
class Ordering
  def initialize(books)
    @books = books
  end

  def order
    return @sets if @sets

    sets = []
    @explanations = []

    sets += standalone_books
    sets += graphs

    @sets = sets.compact
  end

  def explanations
    order
    @explanations ||= []
    @explanations.compact
  end

  def to_image(filename = 'order')
    order
    graph = GraphViz.new(:G, type: :digraph)
    @sets.each do |set|
      set.to_image(graph)
    end
    graph.output(png: "output/#{filename}-#{Time.now.iso8601}.png")
  end

  private

  def standalone_books
    return @standalone_books if @standalone_books

    standalones = @books.reject { |book| in_graphs?(book) }
    @standalone_books = standalones.map { |book|
      @explanations << "#{book.title} is standalone."
      BookSet.construct { |set| set.add(book) }
    }
  end

  # rubocop:todo Metrics/MethodLength
  def graphs
    @graphs ||=
      BookSet.construct do |set| # rubocop:disable Style/BlockDelimiters
        @books.each do |book|
          (@books - [book]).each do |potential_predecessor|
            next unless potential_predecessor.must_precede?(book)

            new_explanations =
              potential_predecessor.
              explanations_for_preceding(book)
            set.add(potential_predecessor, must_precede: book,
                                           explanations: new_explanations)
            @explanations.concat(new_explanations)
          end
        end
      end.disconnected_graphs
  end
  # rubocop:enable Metrics/MethodLength

  def in_graphs?(book)
    graphs.any? { |graph| graph.books.include?(book) }
  end
end
