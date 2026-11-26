require_relative '../piece.rb'

class King < Piece
  DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1], [0, 1], [0, -1], [-1, 0], [1, 0]].freeze

  def directions
    DIRECTIONS
  end

  private

  def scan_for_moves(board_state:, current_row:, current_col:, delta_row:, delta_col:, attack: false)
    tiles = Set.new
    row = current_row + delta_row
    col = current_col + delta_col

    if row.between?(0, TOTAL_ROWS - 1) && col.between?(0, TOTAL_COLS - 1)
      tile = board_state[row][col]

      if tile.piece.nil?
        tiles << tile
      elsif tile.piece.color == color
        tiles << tile if attack
      else
        tiles << tile
      end
    end
    tiles
  end
end
