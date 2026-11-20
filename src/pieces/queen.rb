require_relative '../piece.rb'

class Queen < Piece
  DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1], [0, 1], [0, -1], [-1, 0], [1, 0]].freeze

  def directions
    DIRECTIONS
  end
end
