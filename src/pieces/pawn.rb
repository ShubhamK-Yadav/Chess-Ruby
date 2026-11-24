require_relative '../piece.rb'

class Pawn < Piece
  def row_delta
    color == 'white' ? -1 : 1
  end

  def find_moves(board_state:, current_tile:)
    valid_move_tiles = Set.new
    current_row = current_tile.row
    current_col = current_tile.col

    # check out of bounds (row 0 and 7)
    if (current_row + row_delta).between?(0, 7)
      first_tile = board_state[current_row + row_delta][current_col]
      valid_move_tiles << first_tile if first_tile.piece.nil?

      unless @moved
        second_tile = board_state[current_row + (row_delta * 2)][current_col]
        valid_move_tiles << second_tile if second_tile.piece.nil? && first_tile.piece.nil?
      end
    end
    diagonal_capture(board_state:, current_row:, current_col:, valid_move_tiles:)
  end

  def diag_moves_for_check(board_state:, current_tile:)
    current_row = current_tile.row
    current_col = current_tile.col

    diag_move_tiles(board_state:, current_row:, current_col:)
  end

  private

  def diag_move_tiles(board_state:, current_row:, current_col:)
    tiles = Set.new

    if (current_row + row_delta).between?(0, 7)
      if (current_col - 1) >= 0
        left_tile = board_state[current_row + row_delta][current_col - 1]
        tiles << left_tile unless left_tile.nil?
      end

      if (current_col + 1) <= 7
        right_tile = board_state[current_row + row_delta][current_col + 1]
        tiles << right_tile unless right_tile.nil?
      end
    end

    tiles
  end

  def diagonal_capture(board_state:, current_row:, current_col:, valid_move_tiles:)
    diag_tiles = diag_move_tiles(board_state:, current_row:, current_col:)

    diag_tiles.each do |tile|
      valid_move_tiles << tile if !tile.piece.nil? && tile&.piece&.color != color
    end

    valid_move_tiles
  end

  def en_passant
  end
end
