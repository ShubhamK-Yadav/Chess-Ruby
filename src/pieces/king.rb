require_relative '../piece.rb'

class King < Piece
  DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1], [0, 1], [0, -1], [-1, 0], [1, 0]].freeze

  def valid_moves(board_state:, current_tile:)
    find_valid_moves(board_state:, current_tile:)
  end

  private

  def find_valid_moves(board_state:, current_tile:)
    current_row = current_tile.row
    current_col = current_tile.col

    directional_moves = DIRECTIONS.map do |delta_row, delta_col|
      moves_in_directions(
        board_state:,
        current_row:,
        current_col:,
        delta_row:,
        delta_col:
      )
    end

    # :|, : creates a symbol
    # e.g: :color, etc
    # the reduce method takes in a method name as a parameter so we | which is the union method
    directional_moves = directional_moves.reduce(Set.new, :|)
    checked_positions = checks_from_enemy_pieces(board_state:)
    compute_available_valid_moves(checked_positions:, directional_moves:)
  end

  def compute_available_valid_moves(checked_positions:, directional_moves:)
    directional_moves - checked_positions
  end

  # computes valid moves in each direction denoted using vectors in the DIRECTIONS 2d Array
  def moves_in_directions(board_state:, current_row:, current_col:, delta_row:, delta_col:)
    valid_move_tiles = Set.new
    row = current_row + delta_row
    col = current_col + delta_col

    if row.between?(0, TOTAL_ROWS - 1) && col.between?(0, TOTAL_COLS - 1)
      tile = board_state[row][col]
      if tile.piece.nil?
        valid_move_tiles << tile
      elsif tile.piece.color != self.color
        valid_move_tiles << tile
      end
    end
    valid_move_tiles
  end

  def checks_from_enemy_pieces(board_state:)
    enemy_piece_color = self.color == 'white' ? 'black' : 'white'
    enemy_piece_move_tiles = Set.new

    board_state.flatten.each do |tile|
      next if tile.piece.nil?

      curr_piece = tile.piece
      next if curr_piece.color != enemy_piece_color

      moves = if curr_piece.instance_of?(King)
                enemy_king_moves_for_checks(board_state:, current_tile: tile)
              elsif curr_piece.instance_of?(Pawn)
                curr_piece.diag_moves_for_check(board_state:, current_tile: tile)
              else
                curr_piece.valid_moves(board_state:, current_tile: tile)
              end
      enemy_piece_move_tiles << moves
    end
    enemy_piece_move_tiles
  end

  def enemy_king_moves_for_checks(board_state:, current_tile:)
    current_row = current_tile.row
    current_col = current_tile.col

    directional_moves = DIRECTIONS.map do |delta_row, delta_col|
      moves_in_directions(
        board_state:,
        current_row:,
        current_col:,
        delta_row:,
        delta_col:
      )
    end

    directional_moves.reduce(Set.new, :|)
  end
end
