module Sudoku
  class InvalidSet

    def add(cells)
      sets << cells.map(&:value)
    end

    def sets
      @sets ||= []
    end

    def invalid?(current)
      !sets.detect { |set| set == current }.nil?
    end

    def invalids_for_position(index)
      sets.map { |set| set[index] }.select { |v| v.is_a?(Integer) }.uniq
    end

  end
end
