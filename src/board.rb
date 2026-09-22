require 'ruby2d'
require_relative 'tile'
require_relative 'piece'

class Board
  ROWS = 8
  COLS = 8
  X_POS = 100
  Y_POS = 100
  WIDTH = 600
  HEIGHT = 600
  SHIFT_X_POS = 10
  SHIFT_Y_POS = 5
  BOARD_Z = 10

  PIECE_WIDTH = 50 
  PIECE_HEIGHT = 64
  PIECE_Z = 20

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

  def register_events
    Window.on :mouse_down do |event|
      handle_click(x: event.x, y:event.y)
    end
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
        color = char == char.upcase ? 'white':'black'
        piece_class = PIECE_CLASSES[char.downcase]
        place_piece(piece_class:, tile:, color:,)
        j += 1
      end
    end
  end

  private

  def handle_click(x:, y:)
    tile = tile_at(x:, y:)
    return unless tile
  end

  def tile_at(x:, y:)
    # TODO using the x and y, find the tile that the x and y belong to
    # then check if there is a piece on it by checking the occupied boolean
    # then move the piece, change the occupied booleans of the from and to tiles.
  end

  def place_piece(piece_class:, tile:, color:)
    image_path = "../assets/#{color}_#{piece_class.to_s.downcase}.png"
    sprite = Image.new(
      image_path,
      x: tile.x+SHIFT_X_POS,
      y: tile.y+SHIFT_Y_POS,
      z: PIECE_Z,
      width: PIECE_WIDTH,
      height: PIECE_HEIGHT
    )

    curr_piece = piece_class.new(name: piece_class, x_pos: tile.x, y_pos: tile.y, color:, sprite:)
    tile.set_piece(piece: curr_piece)
  end
end
