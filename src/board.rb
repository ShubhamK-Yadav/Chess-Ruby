require_relative 'tile'

class Board
  ROWS = 8
  COLS = 8
  X_POS = 100
  Y_POS = 100
  WIDTH = 600, HEIGHT = 600

  # TODO: Render Board
  # 1. Create a Shape area for the board (is this needed?)
  # 2. Create individual tiles mapped to the 2d array.

  def initialize(rows: ROWS, cols: COLS, width: WIDTH, height: HEIGHT)
    @rows = rows
    @cols = cols
    @width = width
    @height = height
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
        print tile
      end
      puts
    end
  end
end