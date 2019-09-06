defmodule Runner do
  def main(_argv) do
    board = Board.create(9)

    function_one = Chooser.def_function("human")
    function_two = Chooser.def_function("cpu")

    player_one = Player.new("X", function_one)
    player_two = Player.new("O", function_two)

    players = Enum.shuffle([player_one, player_two])

    TicTacToe.play_game(board, players)
  end
end
