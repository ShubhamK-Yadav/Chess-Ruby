class Tile
  def initialize(
    occupied: false,
    width: 20,
    height: 20,
    x_pos: 30,
    y_pos: 30,
    color: 'black'
    )
    @occupied = occupied
    @width = width
    @height = height
    @x_pos = x_pos
    @y_pos = y_pos
    @color = color

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
end