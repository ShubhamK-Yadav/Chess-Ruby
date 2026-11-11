require_relative '../piece.rb'

class King < Piece
  DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1], [0, 1], [0, -1], [-1, 0], [1, 0]].freeze

  def valid_moves(board_state:, current_tile:)
    current_row = current_tile.row
    current_col = current_tile.col

    DIRECTIONS.flat_map do |delta_row, delta_col|
      valid_moves_in_directions(
        board_state:,
        current_row:,
        current_col:,
        delta_row:,
        delta_col:
      )
    end

    checks_from_enemy_pieces(board_state:)
  end

  private

  # computes valid moves in each direction denoted using vectors in the DIRECTIONS 2d Array
  def valid_moves_in_directions(board_state:, current_row:, current_col:, delta_row:, delta_col:)
    valid_tiles = []
    row = current_row + delta_row
    col = current_col + delta_col

    if row.between?(0, TOTAL_ROWS - 1) && col.between?(0, TOTAL_COLS - 1)
      tile = board_state[row][col]
      if tile.piece.nil?
        valid_tiles << tile
      elsif tile.piece.nil? || tile.piece.color != self.color
        valid_tiles << tile
      end
    end
    valid_tiles
  end

  def checks_from_enemy_pieces(board_state:)
    enemy_piece_color = self.color == 'white' ? 'black' : 'white'
    enemy_piece_move_tiles = []

    board_state.flatten.each do |tile|
      next if tile.piece.nil?

      curr_piece = tile.piece
      next if curr_piece.color != enemy_piece_color

      moves = curr_piece.valid_moves(board_state:, current_tile: tile)
      p [curr_piece.class, tile.row, tile.col, moves.map { |t| [t.row, t.col] }]
      enemy_piece_move_tiles << moves
    end
    p enemy_piece_move_tiles.size
    p enemy_piece_move_tiles.map(&:size)
    # highlight_valid_moves(tiles: enemy_piece_move_tiles)
  end

  def highlight_valid_moves(tiles:)
    return if tiles == []

    @overlay_tiles = tiles.map do |tile|
      Square.new(
        x: tile.x, y: tile.y,
        size: tile.size,
        color: 'red',
        opacity: 0.6,
        z: 15
      )
    end
  end
end
