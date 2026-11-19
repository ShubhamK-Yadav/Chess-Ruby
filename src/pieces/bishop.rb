require_relative '../piece.rb'

class Bishop < Piece
  DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1]].freeze

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
