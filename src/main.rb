require 'ruby2d'
require_relative 'game_window'
require_relative 'board'

TITLE = 'Chess Game!'
WIDTH = 800
HEIGHT = 800
BOARD_WIDTH = 600
BOARD_HEIGHT = 600
BACKGROUND = 'blue'
INITIAL_BOARD_STATE = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"

# TODO: Fenn notation to board position decipher
# Fenn notation can be the array representation? 
# GUI interactable: click and drag etc
window = GameWindow.new(
  title: TITLE,
  width: WIDTH,
  height: HEIGHT,
  background: BACKGROUND
)

board = Board.new(width: BOARD_WIDTH, height: BOARD_HEIGHT)
board.create_board
board.decode_fenn_notation(fenn_board_state: INITIAL_BOARD_STATE)
board.print_board

window.show_window
show

