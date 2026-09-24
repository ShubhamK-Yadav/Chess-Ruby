class Tile
  def initialize(
    width: 20,
    height: 20,
    x: 30,
    y: 30,
    row: 0,
    col: 0,
    color: 'black',
    piece: nil
    )
    @width = width
    @height = height
    @x= x
    @y= y
    @row = row
    @col = col
    @color = color
    @piece = piece
    create_tile
  end

  def create_tile
    @tile_shape = Rectangle.new(
      width: @width,
      height: @height,
      x: @x,
      y: @y,
      color: @color,
      z: 10,
    )
  end

  def change_tile_shape_color(color:)
    @tile_shape.color = color 
  end

  attr_accessor :piece, :color 
  attr_reader :row, :col, :x, :y
end
