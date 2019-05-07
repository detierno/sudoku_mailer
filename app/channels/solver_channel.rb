class SolverChannel < ApplicationCable::Channel

  def subscribed
    #puzzle = Puzzle.find(params[:id])
    #stream_for puzzle
    stream_from 'solver_channel'
  end

end
