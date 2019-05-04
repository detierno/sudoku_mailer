class Puzzle < ApplicationRecord

  validates :board, presence: true

  validate :board_correct_format

  #def board=(value)
    #arr = value.split(/,| /).map { |v| v.to_i }
    #super(arr)
  #end

  private

  def board_correct_format
    errors.add(:board, :invalid_format) and return unless board.is_a?(Array)
    errors.add(:board, :invalid_size) if board.size != 81
    logger.info board
    logger.info board.size
    errors.add(:board, :invalid_values) if board.detect { |cell| !cell.is_a?(Integer) }
  end

end
