module Sudoku
  class Board
    attr_reader :raw_board, :cols

    def initialize(raw_board)
      @raw_board = raw_board
      @cols = []
      9.times { |i| @cols << Col.new(i) }
      parse_rows
      parse_sections
    end

    def cells
      rows.map(&:cells).flatten
    end

    def rows
      @rows ||= []
    end

    def solved?
      cells.select { |cell| !cell.solved? }.empty?
    end

    def sections
      @sections ||= []
    end

    def parse_sections
      9.times { |i| self.sections << Section.new(rows, i) }
    end

    def parse_rows
      raw_board.each_with_index { |row, i| self.rows << Row.new(row, i, cols) }
    end

  end
end
