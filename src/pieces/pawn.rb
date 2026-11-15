require_relative '../piece.rb'

class Pawn < Piece

  def valid_moves(board_state:, current_tile:)
    color_differentiator(board_state:, current_tile:)
  end

  private

  def color_differentiator(board_state:, current_tile:)
    # if white move up, if black, move down
    # diagonal conditional captures
    white_pawn_delta = -1
    black_pawn_delta = 1

    if color == 'white'
      find_moves(board_state:, current_tile:, row_delta: white_pawn_delta)
    else
      find_moves(board_state:, current_tile:, row_delta: black_pawn_delta)
    end
  end

  def find_moves(board_state:, current_tile:, row_delta:)
    valid_tiles = []
    current_row = current_tile.row
    current_col = current_tile.col

    valid_tiles << board_state[current_row + 1][current_col]
    valid_tiles
  end
end
