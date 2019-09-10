defmodule Runner do
  def main(_argv) do
    board = Board.create(9)

    player_one = fn board -> Human.mark(board, "X") end
    player_two = fn board -> CPU.mark(board, "O") end

    players = Enum.shuffle([player_one, player_two])

    TicTacToe.play_game(board, players, WinningRules)
  end
end
