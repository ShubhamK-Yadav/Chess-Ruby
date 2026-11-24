class Piece
  TOTAL_ROWS = 8
  TOTAL_COLS = 8

  PIECE_W = 50
  PIECE_H = 64
  PIECE_Z = 20
  PIECE_X_OFFSET = 10
  PIECE_Y_OFFSET = 5

  def initialize(name:, tile_x:, tile_y:, color:, moved: false)
    @name = name
    @x = tile_x + PIECE_X_OFFSET
    @y = tile_y + PIECE_Y_OFFSET
    @color = color
    @sprite = set_sprite
    @moved = moved
  end

  def set_sprite
    image_path = "../assets/#{@color}_#{@name.to_s.downcase}.png"

    Image.new(
      image_path,
      x: @x,
      y: @y,
      z: PIECE_Z,
      width: PIECE_W,
      height: PIECE_H
    )
  end

  def move_sprite(x:, y:)
    @sprite.x = x
    @sprite.y = y
  end

  def scan_moves(board_state:, current_tile:, total_rows: TOTAL_ROWS, total_cols: TOTAL_COLS)
    current_row = current_tile.row
    current_col = current_tile.col

    directional_moves = directions.map do |delta_row, delta_col|
      tiles_in_directions(
        board_state:,
        current_row:,
        current_col:,
        delta_row:,
        delta_col:
      )
    end
    directional_moves.reduce(Set.new, :|)
  end

  attr_reader :name, :sprite, :color
  attr_accessor :x, :y, :moved, :attacking_tiles

  private

  # computes valid moves in each direction denoted using vectors in the DIRECTIONS 2d Array
  def tiles_in_directions(board_state:, current_row:, current_col:, delta_row:, delta_col:, attack: false)
    tiles = Set.new
    row = current_row + delta_row
    col = current_col + delta_col

    while row.between?(0, TOTAL_ROWS - 1) && col.between?(0, TOTAL_COLS - 1)
      tile = board_state[row][col]

      if tile.piece.nil?
        tiles << tile
      elsif tile.piece.color == color
        tiles << tile if attack
        break
      else
        tiles << tile
        break
      end

      row += delta_row
      col += delta_col
    end
    tiles
  end
end
