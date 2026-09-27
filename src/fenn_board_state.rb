class FennBoardState
  PIECE_CLASSES = {
    'r' => Rook,
    'b' => Bishop,
    'n' => Knight,
    'q' => Queen,
    'k' => King,
    'p' => Pawn
  }

  def self.decode(board_state_string:, empty_board_state:)
    # the output is expected to be a 2D array
    row = 0
    col = 0

    board_state_string.each_char do |char|
      # '/' means move to the next row on the chess board
      if char == '/'
        row += 1
        col = 0
      elsif char.match?(/\d/)
        # char is a number then skip that many cols
        col += char.to_i
      else
        self.decode_piece_char(char:, row:, col:, empty_board_state:)
        col += 1
      end
    end
  end

  def self.decode_piece_char(char:, row:, col:, empty_board_state:)
    tile = empty_board_state[row][col]
    color = char.upcase == char ? 'white' : 'black'
    piece_class = PIECE_CLASSES[char.downcase]

    curr_piece = piece_class.new(name: piece_class, tile_x: tile.x, tile_y: tile.y, color:)
    tile.piece = curr_piece
  end

  def self.encode 
  end

  # def self.validate(board_state:)
  #   if board_state == valid
  #     return true
  #   else
  #     pp "The provided board state is invalid!"
  #     return false
  #   end
  # end
end

