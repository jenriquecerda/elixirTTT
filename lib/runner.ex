defmodule Runner do
  def main(_argv) do
    board = Board.create(9)

    player_one = fn board -> Human.mark(board, "O") end

    options = fn board -> Board.blank_spaces(board) end
    # options = fn board -> MiniMax.options(&WinningRules.winner/1, board, ["X", "O"]) end
    player_two = fn board -> CPU.mark(board, "X", &Chooser.choose/1, options) end

    players = Enum.shuffle([player_one, player_two])

    IO.puts(BoardPresenter.to_string(TicTacToe.play_game(board, players, WinningRules)))
  end
end
