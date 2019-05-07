module Sudoku
  class Cell
    attr_reader :readonly, :row, :col
    attr_accessor :value, :solved, :section

    def initialize(value, row:, col:)
      @value = value
      @row = row
      @col = col
      @readonly = true unless value == 0
      @solved = (value != 0) ? true : false
    end

    def stall!
      @stalled = true
    end

    def stalled?
      @stalled
    end

    def assign_value(index)
      return if readonly
      self.value = valid_candidate(index)
    end

    def valid_candidate(index)
      candidate = nil

      while candidate.nil?
        cand = (candidates - invalid_candidates).first

        if cand.nil?
          candidate = '-'
        elsif row.values.include?(cand) || col.values.include?(cand) || section.values.include?(cand)
          self.invalid_candidates << cand
        else
          self.solved = true
          candidate = cand
        end
      end

      candidate
    end

    def valid?
      value.is_a?(Integer)
    end

    def solved?
      @solved
    end

    def reset_invalid_candidates
      @invalid_candidates = []
    end

    def candidates
      [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def invalid_candidates
      @invalid_candidates ||= []
    end
  end
end
