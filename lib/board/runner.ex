defmodule Runner do
  def main(_argv) do
    players = [Player.new("X", Human), Player.new("O", CPU)]
    board = Board.create(9)
    a = TicTacToe.play_game(board, players)
  end
end
