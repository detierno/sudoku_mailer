module Sudoku
  class Solver
    attr_reader :board
    attr_accessor :backtrack_index

    def initialize(board)
      @board = Board.new(board)
      @backtrack_index = 0
    end

    def assign_current_cell
      current_cell.assign_value
    end

    def invalid_sets
      @invalid_sets ||= InvalidSet.new
    end

    def solve
      while board.solved? == false
        break if backtrack_index < 0

        current_cell.assign_value(backtrack_index)

        ActionCable.server.broadcast 'solver_channel', index: backtrack_index, value: current_cell.value

        if invalid_sets.invalid?(board.cells.map(&:value))
          current_cell.reset_invalid_candidates
          move_back
        else
          if current_cell.valid?
            move_forward
            current_cell.reset_invalid_candidates
          else
            invalid_sets.add(board.cells)
            current_cell.reset_invalid_candidates
            move_back
          end
        end
      end

      board.rows.map { |row| row.cells.map(&:value) }
    end

    def current_cell
      board.cells[backtrack_index]
    end

    def move_back
      self.backtrack_index -= 1
    end

    def move_forward
      self.backtrack_index += 1
    end

    def to_s
      print "-------------------------------------\n"
      board.rows.each do |row|
        result = row.cells.map &:value
        print "| #{result.join(' | ')} |\n"
      end
      print "-------------------------------------\n"
    end
  end
end
