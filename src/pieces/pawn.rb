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

    # check out of bounds (row 0 and 7)
    if (current_row + row_delta).between?(0, 7)
      first_tile = board_state[current_row + row_delta][current_col]
      valid_tiles << first_tile if first_tile.piece.nil?
    end

    unless @moved
      second_tile = board_state[current_row + (row_delta * 2)][current_col]
      valid_tiles << second_tile if second_tile.piece.nil? && first_tile.piece.nil?
    end
    diagonal_capture(board_state:, current_row:, current_col:, row_delta:, valid_tiles:)
  end

  def diagonal_capture(board_state:, current_row:, current_col:, row_delta:, valid_tiles:)
    if (current_row + row_delta).between?(0, 7)
      if (current_col - 1) >= 0
        left_tile = board_state[current_row + row_delta][current_col - 1]
        valid_tiles << left_tile if !left_tile.piece.nil? && left_tile&.piece&.color != self.color
      end

      if (current_col + 1) <= 7
        right_tile = board_state[current_row + row_delta][current_col + 1]
        valid_tiles << right_tile if !right_tile.piece.nil? && right_tile&.piece&.color != self.color
      end
    end

    if (current_col + 1) <= 7
      right_tile = board_state[current_row + row_delta][current_col + 1]
      valid_tiles << right_tile if !right_tile.piece.nil? && right_tile&.piece&.color != self.color
    end
    # check out of bounds (cols 0 and 7)
    # return valid_tiles if left_tile.piece.nil? && right_tile.piece.nil?

    valid_tiles
  end
end
