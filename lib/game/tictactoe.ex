defmodule TicTacToe do
  def play_game(board, players, winning_rules, output) do
    [current_player, _] = players

    output.(board)

    unless Board.is_full?(board) || winning_rules.has_winner?(board) do
      {:ok, marked_board} = current_player.(board)

      players = Swapper.swap(players)

      play_game(marked_board, players, winning_rules, output)
    else
      if is_nil(winning_rules.winner(board)) do
        output.(BoardPresenter.to_string(board) <> "\nDraw\n")
        board
      else
        output.(BoardPresenter.to_string(board) <> "\nPlayer #{winning_rules.winner(board)} wins\n")
        board
      end
    end
  end
end
