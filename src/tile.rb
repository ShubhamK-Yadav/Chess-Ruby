class Tile
  def initialize(
    occupied: false,
    width: 20,
    height: 20,
    x_pos: 30,
    y_pos: 30,
    color: 'black',
    piece: nil
    )
    @occupied = occupied
    @width = width
    @height = height
    @x_pos = x_pos
    @y_pos = y_pos
    @color = color
    @piece = piece
    create_tile
  end

  def create_tile
    @tile_shape = Rectangle.new(
      width: @width,
      height: @height,
      x: @x_pos,
      y: @y_pos,
      color: @color,
      z: 10,
    )
  end

  def set_piece(piece:)
    @piece = piece
  end

  def piece
    @piece
  end

  def x
    @x_pos
  end

  def y
    @y_pos
  end
end
