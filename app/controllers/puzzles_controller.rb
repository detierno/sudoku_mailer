class PuzzlesController < ApplicationController
  before_action :load_puzzles, only: [:index, :show]
  before_action :set_puzzle, only: [:show, :edit, :update, :destroy]

  def index
    @puzzles = Puzzle.all
  end

  def show
    SudokuSolverJob.set(wait: 1.second).perform_later(@puzzles.first.id)
  end

  def new
    @puzzle = Puzzle.new
  end

  def edit
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)

    if @puzzle.save
      redirect_to @puzzle, notice: 'Puzzle was successfully created.'
    else
      render :new
    end
  end

  def update
    if @puzzle.update(puzzle_params)
      redirect_to @puzzle, notice: 'Puzzle was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @puzzle.destroy
    redirect_to puzzles_url, notice: 'Puzzle was successfully destroyed.'
  end

  private
    def load_puzzles
      @puzzles = Puzzle.all
    end

    def set_puzzle
      @puzzle = Puzzle.find(params[:id])
    end

    def puzzle_params
      params.require(:puzzle).permit(:sent_by, :board)
    end
end
