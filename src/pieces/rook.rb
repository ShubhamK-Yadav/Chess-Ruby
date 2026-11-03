require_relative '../piece'

class Rook < Piece
  # directions in an array somehow or hash
  # use the data structure, compute all the valid moves

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

  private

  # computes valid moves in each direction denoted using vectors in the DIRECTIONS 2d Array
  def valid_moves_in_directions(board_state:, current_row:, current_col:, delta_row:, delta_col:)
    valid_tiles = []
    row = current_row + delta_row
    col = current_col + delta_col

    while row.between?(0, TOTAL_ROWS - 1) && col.between?(0, TOTAL_COLS - 1)
      tile = board_state[row][col]

      if tile.piece.nil?
        valid_tiles << tile
      elsif !tile.piece.nil? && tile.piece.color == self.color
        break
      else
        valid_tiles << tile
        break
      end

      row += delta_row
      col += delta_col
    end
    valid_tiles
  end
end
