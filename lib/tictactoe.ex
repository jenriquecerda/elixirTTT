defmodule TicTacToe do
  def start(board, io) do
    ask_for_move(board, io)
  end

  defp ask_for_move(board, io) do
    unless Board.is_full?(board) do
      {space, _} = IO.gets(io, "Please choose space?\n") |> String.trim() |> Integer.parse()
      updated_board = Board.mark(board, space, "X")
      ask_for_move(updated_board, io)
    else
      board
    end
  end
end
