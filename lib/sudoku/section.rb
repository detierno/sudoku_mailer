module Sudoku
  class Section
    attr_reader :index

    def initialize(rows, index)
      @index = index
      parse_section(rows)
    end

    def cells
      @cells ||= []
    end

    def values
      cells.map &:value
    end

    def parse_section(rows)
      coordinates = sets_by_index[index]

      3.times do |i|
        row_index = coordinates[:init_row] + i
        first_cell = coordinates[:init_col]
        last_cell = coordinates[:init_col] + 2

        row = rows[row_index]
        cells = row.cells[first_cell..last_cell]
        cells.each { |c| c.section = self }
        self.cells << cells
        self.cells.flatten!
      end
    end

    def sets_by_index
      {
        0 => { init_row: 0, init_col: 0 },
        1 => { init_row: 0, init_col: 3 },
        2 => { init_row: 0, init_col: 6 },
        3 => { init_row: 3, init_col: 0 },
        4 => { init_row: 3, init_col: 3 },
        5 => { init_row: 3, init_col: 6 },
        6 => { init_row: 6, init_col: 0 },
        7 => { init_row: 6, init_col: 3 },
        8 => { init_row: 6, init_col: 6 },
      }
    end

  end
end
