require_relative '../piece'

class Rook < Piece
  DIRECTIONS = [[0, 1], [0, -1], [-1, 0], [1, 0]].freeze

  def valid_moves(board_state:, current_tile:)
    current_row = current_tile.row
    current_col = current_tile.col

    DIRECTIONS.flat_map do |delta_row, delta_col|
      valid_moves_in_directions(
        board_state:,
        current_row:,
        current_col:,
        delta_row:,
        delta_col:
      )
    end
  end
end
