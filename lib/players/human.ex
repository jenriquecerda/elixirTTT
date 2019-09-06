defmodule Human do
  def function(board, player) do
    input =
      IO.gets(player.device, "#{player.symbol} Please choose space.\n")
      |> String.trim()
      |> Integer.parse()

    if input == :error do
      function(board, player)
    else
      {space, _} = input

      {status, result} = Board.mark(board, space, player.symbol)

      case {status, result} do
        {:ok, result} ->
          IO.puts(player.device, BoardPresenter.to_string(result))
          {status, result}

        {:error, _} ->
          function(board, player)
      end
    end
  end
end
