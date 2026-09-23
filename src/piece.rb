class Piece 
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

  def valid_moves(board_state:)
    raise NotImplementedError
  end
  
  attr_reader :name, :sprite
end

class Rook < Piece
  def valid_moves(board_state:, current_tile:)
    # valid_move_tiles = []
    #
    # board_state.each do |row|
    #   row.each do |tile|
    #     if current_tile == tile
    #       valid_move_tiles << r {row.each do |r|}
    #     end
    #   end
    # end
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
