class Piece 
  def initialize(x_pos:, y_pos:, color:, sprite:)
    @x_pos = x_pos
    @y_pos = y_pos
    @color = color
    @sprite = sprite
  end

  def move
    raise NotImplementedError
  end

  def name
    raise NotImplementedError
  end

  def get_sprite
    @sprite
  end
end

class Rook < Piece
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
