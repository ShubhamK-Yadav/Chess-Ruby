require_relative 'tile'
require_relative 'piece'

class Board
  ROWS = 8
  COLS = 8
  X_POS = 100
  Y_POS = 100
  WIDTH = 600, HEIGHT = 600

  # TODO: Render Board
  # 1. Create a Shape area for the board (is this needed?)
  # 2. Create individual tiles mapped to the 2d array.
  INITIAL_BOARD_STATE = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

  PIECE_CLASSES = {
    'r' => Rook,
    'b' => Bishop,
    'n' => Knight,
    'q' => Queen,
    'k' => King,
    'p' => Pawn
  }

  def initialize(
        rows: ROWS,
        cols: COLS,
        width: WIDTH,
        height: HEIGHT,
        initial_board_pos: INITIAL_BOARD_STATE
      )
    @rows = rows
    @cols = cols
    @width = width
    @height = height
    @initial_board_pos = initial_board_pos
  end

  def create_board
    tile_w = @width / @cols
    tile_y = @height / @rows
    @board_state = Array.new(@rows) {Array.new(@cols)}

    @board_state = Array.new(@rows) do |i|
      Array.new(@cols) do |j|
        Tile.new(
          occupied: false,
          x_pos: (j * tile_w) + X_POS,
          y_pos: (i * tile_y) + Y_POS,
          width: tile_w,
          height: tile_y,
          color: (i + j).even? ? 'white' : 'black'
        )
      end
    end
  end

  def initial_board
    print("Will create initial board.")
  end

  def print_board
    @board_state.each do |row|
      row.each do |tile|
        if tile.piece
          print tile.piece.class.name
        else
          print " "
        end
      end
      puts
    end
  end

  def decode_fenn_notation(fenn_board_state:)
    # read the string one letter at a time, '/' and ' ' are delimiter
    # lowercase are black pieces and uppercase are white pieces
    # for each char, if / or ' ' then move to the next row else iterate through column?

    i = 0
    j = 0
    fenn_board_state.each_char do |char|
      if char == '/'
        i += 1
        j = 0
      elsif char.match?(/\d/)
        j += char.to_i
      else
        tile = @board_state[i][j]
        color = char == char.upcase ? 'w':'b'
        piece_class = PIECE_CLASSES[char.downcase]
        place_piece(piece_class:, tile:, color:,)
        j += 1
      end
    end
  end

  def place_piece(piece_class:, tile:, color:)
    tile.set_piece(piece: piece_class.new(x_pos: tile.x, y_pos: tile.y, color:))
  end
end
