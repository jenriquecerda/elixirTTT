defmodule TicTacToe do
  def play_game(board, players, winning_rules, output \\ :stdio) do
    [current_player, _] = players

    unless Board.is_full?(board) || winning_rules.has_winner?(board) do
      {:ok, marked_board} = current_player.(board)

      players = Swapper.swap(players)

      play_game(marked_board, players, winning_rules, output)
    else
      if is_nil(winning_rules.winner(board)) do
        IO.puts(output, "Draw")
        board
      else
        IO.puts(output, "Player #{winning_rules.winner(board)} wins")
        board
      end
    end
  end
end
