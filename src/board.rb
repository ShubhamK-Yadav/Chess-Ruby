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
    @tile_w = @width / @cols
    @tile_y = @height / @rows
    @board_state = Array.new(@rows) {Array.new(@cols)}

    @board_state = Array.new(@rows) do |i|
      Array.new(@cols) do |j|
        Tile.new(
          x: (j * @tile_w) + X_POS,
          y: (i * @tile_y) + Y_POS,
          row: i,
          col: j,
          width: @tile_w,
          height: @tile_y,
          color: (i + j).even? ? 'white' : 'black'
        )
      end
    end
  end

  def register_events
    Window.on :mouse_down do |event|
      start_drag(x: event.x, y: event.y)
    end

    Window.on :mouse_move do |event|
      drag(x: event.x, y: event.y)
    end

    Window.on :mouse_up do |event|
      drop(x: event.x, y: event.y)
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

    row = 0
    col = 0

    fenn_board_state.each_char do |char|
      if char == '/'
        row += 1
        col = 0
      elsif char.match?(/\d/)
        col += char.to_i
      else
        decode_piece_char(char:, row:, col:)
        col += 1
      end
    end
  end

  private

  def decode_piece_char(char:, row:, col:)
    tile = @board_state[row][col]
    color = char.upcase == char ? 'white' : 'black'
    piece_class = PIECE_CLASSES[char.downcase]
    place_piece(piece_class:, tile:, color:,)
  end

  def start_drag(x:, y:)
    tile = tile_at(x:, y:)
    return unless tile

    @origin_tile = tile
    @dragging_piece = @origin_tile.piece if @origin_tile.piece != nil

    @valid_tiles = @dragging_piece.valid_moves(board_state: @board_state, current_tile: @origin_tile) 

    change_valid_tiles_color(valid_tiles: @valid_tiles, color: 'green')
  end

  def drag(x:, y:)
    return unless @dragging_piece

    @dragging_piece.move_sprite(
      x: x - PIECE_WIDTH/2,
      y: y - PIECE_HEIGHT/2
    )
  end

  def drop(x:, y:)
    return unless @dragging_piece
    
    # find the valid tiles if there is a piece selected
    target_tile = tile_at(x:, y:) || @origin_tile
    x = target_tile.x + SHIFT_X_POS
    y = target_tile.y + SHIFT_Y_POS

    # change the color of the tile back to original color
    change_valid_tiles_color(valid_tiles: @valid_tiles)

    valid_tile_status = is_target_tile_valid?(target_tile:, valid_tiles: @valid_tiles)

    if valid_tile_status
      @dragging_piece.move_sprite(
        x:,
        y: 
      )
      
      @dragging_piece.x = x
      @dragging_piece.y = y
      
      target_tile.piece = @dragging_piece
      @origin_tile.piece = nil
      
    elsif !valid_tile_status 
      # move sprite back to its original tile
      @dragging_piece.move_sprite(
        x: @dragging_piece.x,
        y: @dragging_piece.y
      )
    end

    @dragging_piece = nil
    @origin_tile = nil
  end

  # check if the target tile is a valid tile (target tile from a valid move)
  def is_target_tile_valid?(target_tile:, valid_tiles: @valid_tiles)
    if target_tile != @origin_tile
      return @valid_tiles.include?(target_tile)
    else
      return false
    end
  end

  def tile_at(x:, y:)
    @board_state.flatten.find do |tile|
      return tile if x.between?(tile.x, tile.x+@tile_w) && y.between?(tile.y, tile.y+@tile_y)
    end
  end

  def place_piece(piece_class:, tile:, color:)
    image_path = "../assets/#{color}_#{piece_class.to_s.downcase}.png"
    x = tile.x+SHIFT_X_POS
    y = tile.y+SHIFT_Y_POS

    sprite = Image.new(
      image_path,
      x:,
      y:,
      z: PIECE_Z,
      width: PIECE_WIDTH,
      height: PIECE_HEIGHT
    )

    curr_piece = piece_class.new(name: piece_class, x:, y:, color:, sprite:)
    tile.piece = curr_piece
  end

  def change_valid_tiles_color(valid_tiles:, color: nil)
    valid_tiles.each do |tile|
      if tile != nil
        tile.change_tile_shape_color(color: color != nil ? color : tile.color)
      end
    end
  end
end
