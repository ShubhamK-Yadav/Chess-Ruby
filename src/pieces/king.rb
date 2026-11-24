require_relative '../piece.rb'

class King < Piece
  DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1], [0, 1], [0, -1], [-1, 0], [1, 0]].freeze

  def find_moves(board_state:, current_tile:, attack: false)
    current_row = current_tile.row
    current_col = current_tile.col

    directional_moves = DIRECTIONS.map do |delta_row, delta_col|
      scan_for_moves(
        board_state:,
        current_row:,
        current_col:,
        delta_row:,
        delta_col:
      )
    end

    directional_moves = directional_moves.reduce(Set.new, :|)
    return directional_moves if attack

    scan_available_moves(directional_moves:, board_state:)
  end

  private

  def scan_available_moves(directional_moves:, board_state:)
    attacked_positions = enemy_attacking_tiles(board_state:)
    compute_available_moves(attacked_positions:, directional_moves:)
  end

  def compute_available_moves(attacked_positions:, directional_moves:)
    directional_moves - attacked_positions
  end

  # computes valid moves in each direction denoted using vectors in the DIRECTIONS 2d Array
  def scan_for_moves(
    board_state:,
    current_row:,
    current_col:,
    delta_row:,
    delta_col:,
    attack: false
  )
    tiles = Set.new
    row = current_row + delta_row
    col = current_col + delta_col

    if row.between?(0, TOTAL_ROWS - 1) && col.between?(0, TOTAL_COLS - 1)
      tile = board_state[row][col]

      if tile.piece.nil?
        tiles << tile
      elsif tile.piece.color == color
        tiles << tile if attack
      else
        tiles << tile
      end

    end
    tiles
  end

  def enemy_attacking_tiles(board_state:)
    enemy_piece_color = color == 'white' ? 'black' : 'white'
    enemy_piece_move_tiles = Set.new

    board_state.flatten.each do |tile|
      next if tile.piece.nil?

      curr_piece = tile.piece
      next if curr_piece.color != enemy_piece_color

      moves = if curr_piece.instance_of?(Pawn)
                curr_piece.diag_moves_for_check(board_state:, current_tile: tile)
              else
                curr_piece.find_moves(board_state:, current_tile: tile, attack: true)
              end
      enemy_piece_move_tiles |= moves
    end
    enemy_piece_move_tiles
  end
end
