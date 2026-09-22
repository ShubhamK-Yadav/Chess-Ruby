class Piece 
  def initialize(name:, x_pos:, y_pos:, color:, sprite:)
    @name = name
    @x_pos = x_pos
    @y_pos = y_pos
    @color = color
    @sprite = sprite
  end

  def move_sprite(x_pos:, y_pos:)
    @sprite.x = x_pos
    @sprite.y = y_pos
  end

  def name
    @name
  end

  def get_sprite
    @sprite
  end

  def valid_moves(board_state:)
    raise NotImplementedError
  end
end

class Rook < Piece
  def valid_moves(board_state:, current_tile:)
    valid_move_tiles = []
    
    board_state.each do |row|
      row.each do |tile|
        if current_tile == tile
          valid_move_tiles << r {row.each do |r|}
        end
      end
    end
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
