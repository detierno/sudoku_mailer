module Sudoku
  class Row
    attr_reader :index

    def cells
      @cells ||= []
    end

    def values
      cells.map &:value
    end

    def initialize(row, index, cols)
      @index = index
      row.each_with_index do |cell, i|
        cell = Cell.new(cell, row: self, col: cols[i])
        self.cells << cell
        cols[i].cells << cell
      end
    end

  end
end
