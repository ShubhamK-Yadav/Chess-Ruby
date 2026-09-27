require_relative '../piece.rb'

class Rook < Piece
  def valid_moves(board_state:, current_tile:)
    valid_move_tiles = []

    current_row = current_tile.row
    current_col = current_tile.col

    valid_move_tiles_up = valid_moves_up_direction(
      board_state:, 
      current_row:,
      current_col: 
    ) 
    
    valid_move_tiles_down = valid_moves_down_direction(
      board_state:, 
      current_row:,
      current_col: 
    ) 

    valid_move_tiles_left = valid_moves_left_direction(
      board_state:, 
      current_row:,
      current_col: 
    ) 

    valid_move_tiles_right = valid_moves_right_direction(
      board_state:, 
      current_row:,
      current_col: 
    )

    valid_move_tiles_up + valid_move_tiles_down + valid_move_tiles_left + valid_move_tiles_right
  end

  private 

  def valid_moves_up_direction(board_state:, current_row:, current_col:)
    row = current_row + 1
    valid_tiles = []

    while row < TOTAL_ROWS && row > current_row
      if board_state[row][current_col].piece == nil
        valid_tiles << board_state[row][current_col]
      elsif board_state[row][current_col].piece != nil && board_state[row][current_col].piece.color == self.color
        break
      else
        valid_tiles << board_state[row][current_col]
        break
      end
      row += 1
    end
    valid_tiles
  end

  def valid_moves_down_direction(board_state:, current_row:, current_col:)
    row = current_row - 1
    valid_tiles = []

    while row < current_row && row > -1
      if board_state[row][current_col].piece == nil
        valid_tiles << board_state[row][current_col]
      elsif board_state[row][current_col].piece != nil && board_state[row][current_col].piece.color == self.color
        break
      else
        valid_tiles << board_state[row][current_col]
        break
      end
      row -= 1
    end
    valid_tiles
  end

  def valid_moves_right_direction(board_state:, current_row:, current_col:)
    col = current_col + 1
    valid_tiles = []

    while col < TOTAL_COLS && col > current_col
      if board_state[current_row][col].piece == nil
        valid_tiles << board_state[current_row][col]
      elsif board_state[current_row][col].piece != nil && board_state[current_row][col].piece.color == self.color
        break
      else
        valid_tiles << board_state[current_row][col]
        break
      end
      col += 1
    end
    valid_tiles 
  end

  def valid_moves_left_direction(board_state:, current_row:, current_col:)
    col = current_col - 1
    valid_tiles = []

    while col < current_col && col > -1
      if board_state[current_row][col].piece == nil
        valid_tiles << board_state[current_row][col]
      elsif board_state[current_row][col].piece != nil && board_state[current_row][col].piece.color == self.color
        break
      else
        valid_tiles << board_state[current_row][col]
        break
      end
      col -= 1
    end
    valid_tiles
  end
end

