defmodule TicTacToe do
  @default_message "Please choose space.\n"

  def start(players, board, io \\ :stdio, screen) do
    ask_for_move(players, board, io, screen)
  end

  defp ask_for_move(players, board, io, screen, message \\ @default_message) do
    [current_player, _] = players

    unless Board.is_full?(board) do
      {space, _} = IO.gets(io, message) |> String.trim() |> Integer.parse()
      {status, result} = Board.mark(board, space, current_player)

      case {status, result} do
        {:ok, result} ->
          IO.puts(io, screen.display(result))

          players = Swapper.swap(players)
          ask_for_move(players, result, io, screen)

        {:error, result} ->
          ask_for_move(players, board, io, screen, result <> " " <> @default_message)
      end
    else
      board
    end
  end
end
