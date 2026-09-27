require 'ruby2d'
require_relative 'game_window'
require_relative 'board'
require_relative 'fenn_board_state'

TITLE = 'Chess Game!'
WIDTH = 800
HEIGHT = 800
BOARD_WIDTH = 600
BOARD_HEIGHT = 600
BACKGROUND = 'blue'
INITIAL_BOARD_STATE = "rnbqkbnr/pppppp/8/8/8/8/PPPPPP/RNBQKBNR"

window = GameWindow.new(
  title: TITLE,
  width: WIDTH,
  height: HEIGHT,
  background: BACKGROUND
)

board = Board.new(width: BOARD_WIDTH, height: BOARD_HEIGHT)
board.create_board
FennBoardState.decode(board_state_string: INITIAL_BOARD_STATE, empty_board_state: board.board_state)
# board.decode_fenn_notation(fenn_board_state: INITIAL_BOARD_STATE)
board.print_board
board.register_events

window.show_window
show

