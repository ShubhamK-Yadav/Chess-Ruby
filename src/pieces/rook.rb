require_relative '../piece'

class Rook < Piece
  DIRECTIONS = [[0, 1], [0, -1], [-1, 0], [1, 0]].freeze

  def directions
    DIRECTIONS
  end
end
