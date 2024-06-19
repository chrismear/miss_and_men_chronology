# frozen_string_literal: true

require_relative 'book_set'

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
    sets += directed_graphs
    sets += cyclic_graphs

    @sets = sets.compact
  end

  def explanations
    order
    @explanations ||= []
    @explanations.compact
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
  def directed_graphs
    @directed_graphs ||=
      BookSet.construct do |set| # rubocop:disable Style/BlockDelimiters
        @books.select(&:changes?).each do |book_with_changes|
          (@books - [book_with_changes]).each do |potential_predecessor|
            next unless potential_predecessor.must_precede?(book_with_changes)

            @explanations +=
              potential_predecessor.
              explanations_for_preceding(book_with_changes)

            set.add(potential_predecessor, must_precede: book_with_changes)
          end
        end
      end.disconnected_graphs
  end
  # rubocop:enable Metrics/MethodLength

  def cyclic_graphs
    []
  end

  # Returns true if the books is in either the directed graphs or the cyclic
  # graphs.
  def in_graphs?(book)
    found_in_graphs = false
    directed_graphs.each do |graph|
      found_in_graphs ||= graph.books.include?(book)
    end
    cyclic_graphs.each do |graph|
      found_in_graphs ||= graph.books.include?(book)
    end
    found_in_graphs
  end
end
