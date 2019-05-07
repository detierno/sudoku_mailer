class Puzzle < ApplicationRecord

  validates :board, presence: true

  validate :board_correct_format

  #def board=(value)
    #arr = value.split(/,| /).map { |v| v.to_i }
    #super(arr)
  #end

  def formatted_board
    board_dup = board.dup
    board_arrs = []
    9.times { board_arrs << board_dup.slice!(0, 9) }
    board_arrs
  end

  private

  def board_correct_format
    errors.add(:board, :invalid_format) and return unless board.is_a?(Array)
    errors.add(:board, :invalid_size) if board.size != 81
    logger.info board
    logger.info board.size
    errors.add(:board, :invalid_values) if board.detect { |cell| !cell.is_a?(Integer) }
  end

end
