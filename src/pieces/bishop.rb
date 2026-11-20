require_relative '../piece.rb'

class Bishop < Piece
  DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1]].freeze

  def directions
    DIRECTIONS
  end
end
