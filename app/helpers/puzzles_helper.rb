module PuzzlesHelper

  def format_board(board)
    board = board.dup

    output = []

    9.times do
      row = board.slice!(0, 9)
      output << content_tag(:tr, row.map { |v| content_tag(:td, v) }.join(''))
    end

    content_tag(:table, output.join('')).html_safe
  end

end
