defmodule TicTacToe do
  def play_game(board, players) do
    [current_player, _] = players

    unless Board.is_full?(board) do
      {:ok, board} =
        current_player.mode.choose(board, current_player.symbol, current_player.chooser)

      players = Swapper.swap(players)
      play_game(board, players)
    else
      board
    end
  end
end
