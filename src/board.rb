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

  LABEL_SIZE = 12
  LABEL_Z = 5
  INITIAL_BOARD_STATE = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

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
  @player_turn = 'white'
  end

  def create_board
    @tile_size = @width / @cols
    @board_state = Array.new(@rows) {Array.new(@cols)}

    @board_state = Array.new(@rows) do |i|
      Array.new(@cols) do |j|
        label_rows_and_cols(row: i, col: j)
        Tile.new(
          x: (j * @tile_size) + X_POS,
          y: (i * @tile_size) + Y_POS,
          row: i,
          col: j,
          size: @tile_size,
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
  attr_reader :board_state

  private

  def label_rows_and_cols(row:, col:)
    numerical_val = (8 - row).to_s
    alphabetical_val = ('a'.ord + col).chr
    x = (col * @tile_size) + X_POS
    y = (row * @tile_size) + Y_POS
    color = (row + col).odd? ? 'white' : 'black'

    if col.zero?
      draw_label(
        numerical_val,
        x: x + 2,
        y: y + 5,
        color:
      )
    end

    if row == 7
      draw_label(
        alphabetical_val,
        x: x + @tile_size - 10,
        y: y + @tile_size - 16,
        color:
      )
    end
  end

  def draw_label(text, x:, y:, color:)
    Text.new(
      text,
      x:,
      y:,
      color:,
      z: LABEL_Z,
      size: LABEL_SIZE
    )
  end

  def start_drag(x:, y:)
    tile = tile_at(x:, y:)
    return unless tile

    @origin_tile = tile
    return if @origin_tile.piece.nil?
    return unless @origin_tile.piece.color == @player_turn

    @dragging_piece = @origin_tile.piece
    @valid_tiles = @dragging_piece.valid_moves(board_state: @board_state, current_tile: @origin_tile)

    highlight_valid_moves(tiles: @valid_tiles)
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
    clear_highlights

    valid_tile_status = target_tile_valid?(target_tile:)

    if valid_tile_status
      @dragging_piece.x = x
      @dragging_piece.y = y

      @dragging_piece.move_sprite(
        x:,
        y:
      )
      @player_turn = @player_turn == 'white' ? 'black' : 'white'

      target_tile&.piece&.sprite&.remove
      target_tile.piece = @dragging_piece
      @dragging_piece.moved = true
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
  def target_tile_valid?(target_tile:)
    return false if target_tile == @origin_tile
    return false if !target_tile.piece.nil? && target_tile.piece.instance_of?(King)

    @valid_tiles.include?(target_tile)
  end

  def tile_at(x:, y:)
    @board_state.flatten.each do |tile|
      return tile if x.between?(tile.x, tile.x+@tile_size) && y.between?(tile.y, tile.y+@tile_size)
    end
    false
  end

  def highlight_valid_moves(tiles:)
    return if tiles == []

    @overlay_tiles = tiles.map do |tile|
      Square.new(
        x: tile.x, y: tile.y,
        size: tile.size,
        color: 'green',
        opacity: 0.6,
        z: 15
      )
    end
  end

  def clear_highlights
    @overlay_tiles&.each(&:remove)
    @overlay_tiles = []
  end
end
