defmodule TicTacToe do
  def play_game(board, players) do
    [current_player, _] = players

    unless Board.is_full(board) do
      {:ok, result} = current_player.marker.(board, current_player)

      players = Swapper.swap(players)

      play_game(result, players)
    else
      board
    end
  end
end
