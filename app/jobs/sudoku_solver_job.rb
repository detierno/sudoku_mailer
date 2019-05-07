class SudokuSolverJob < ApplicationJob
  #queue_as :default

  def perform(puzzle_id)
    puzzle = Puzzle.find(puzzle_id)
    Sudoku::Solver.new(puzzle.formatted_board).solve
  end
end
