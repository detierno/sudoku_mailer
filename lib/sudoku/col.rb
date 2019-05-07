module Sudoku
  class Col
    attr_reader :index

    def initialize(index)
      @index = index
    end

    def cells
      @cells ||= []
    end

    def values
      cells.map &:value
    end
  end
end
