class Piece 
  TOTAL_ROWS = 8
  TOTAL_COLS = 8

  PIECE_W = 50
  PIECE_H = 64
  PIECE_Z = 20
  PIECE_X_OFFSET = 10
  PIECE_Y_OFFSET = 5

  def initialize(name:, tile_x:, tile_y:, color:, sprite: nil)
    @name = name
    @x = tile_x + PIECE_X_OFFSET
    @y = tile_y + PIECE_Y_OFFSET
    @color = color
    @sprite = set_sprite
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

  def valid_moves(board_state:, current_tile:, total_rows: TOTAL_ROWS, total_cols: TOTAL_COLS)
    raise NotImplementedError
  end
  
  attr_reader :name, :sprite, :color
  attr_accessor :x, :y
end
