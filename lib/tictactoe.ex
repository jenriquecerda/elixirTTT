defmodule TicTacToe do
  @default_message "Please choose space.\n"

  def start(board, io) do
    ask_for_move(board, io)
  end

  defp ask_for_move(board, io, message \\ @default_message) do
    unless Board.is_full?(board) do
      {space, _} = IO.gets(io, message) |> String.trim() |> Integer.parse()
      {status, result} = Board.mark(board, space, "X")

      case {status, result} do
        {:ok, result} -> ask_for_move(result, io)
        {:error, result} -> ask_for_move(board, io, result <> " " <> @default_message)
      end
    else
      board
    end
  end
end
