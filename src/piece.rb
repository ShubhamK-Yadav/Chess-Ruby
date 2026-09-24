class Piece 
  TOTAL_ROWS = 8
  TOTAL_COLS = 8

  def initialize(name:, x:, y:, color:, sprite:)
    @name = name
    @x = x
    @y = y
    @color = color
    @sprite = sprite
  end

  def move_sprite(x:, y:)
    @sprite.x = x
    @sprite.y = y
  end

  def valid_moves(board_state:, current_tile:, total_rows: TOTAL_ROWS, total_cols: TOTAL_COLS)
    raise NotImplementedError
  end
  
  attr_reader :name, :sprite, :color
  attr_accessor :x, :y
end

class Rook < Piece
  def valid_moves(board_state:, current_tile:)
    valid_move_tiles = []

    curr_row = current_tile.row
    curr_col = current_tile.col

    row = curr_row + 1
    while row < TOTAL_ROWS && row > curr_row
      if board_state[row][curr_col].piece == nil
        valid_move_tiles << board_state[row][curr_col]
      elsif board_state[row][curr_col].piece != nil && board_state[row][curr_col].piece.color == self.color
        break
      else
        valid_move_tiles << board_state[row][curr_col]
        break
      end
      row += 1
    end

    row = curr_row - 1
    while row < curr_row && row > -1
      if board_state[row][curr_col].piece == nil
        valid_move_tiles << board_state[row][curr_col]
      elsif board_state[row][curr_col].piece != nil && board_state[row][curr_col].piece.color == self.color
        break
      else
        valid_move_tiles << board_state[row][curr_col]
        break
      end
      row -= 1
    end

    col = curr_col + 1
    while col < TOTAL_COLS && col > curr_col
      if board_state[curr_row][col].piece == nil
        valid_move_tiles << board_state[curr_row][col]
      elsif board_state[curr_row][col].piece != nil && board_state[curr_row][col].piece.color == self.color
        break
      else
        valid_move_tiles << board_state[curr_row][col]
        break
      end
      col += 1
    end

    col = curr_col - 1
    while col < curr_col && col > -1
      if board_state[curr_row][col].piece == nil
        valid_move_tiles << board_state[curr_row][col]
      elsif board_state[curr_row][col].piece != nil && board_state[curr_row][col].piece.color == self.color
        break
      else
        valid_move_tiles << board_state[curr_row][col]
        break
      end
      col -= 1
    end

    valid_move_tiles
  end
end

class Pawn < Piece
end

class Knight < Piece
end

class Bishop < Piece
end

class Queen < Piece
end

class King < Piece
end
