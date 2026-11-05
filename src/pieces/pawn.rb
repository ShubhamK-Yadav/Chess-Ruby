require_relative '../piece.rb'

class Pawn < Piece

  def valid_moves(board_state:, current_tile:)
    valid_tiles = []
    current_row = current_tile.row
    current_col = current_tile.col

    valid_tiles << board_state[current_row + 1][current_col]
    valid_tiles
  end
end
