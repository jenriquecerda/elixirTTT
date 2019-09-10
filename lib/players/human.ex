defmodule Human do
  def mark(board, symbol, device \\ :stdio) do
    input =
      IO.gets(device, "#{symbol} Please choose space.\n")
      |> String.trim()
      |> Integer.parse()

    if input == :error do
      mark(board, symbol, device)
    else
      {space, _} = input

      {status, result} = Board.mark(board, space, symbol)

      case {status, result} do
        {:ok, result} ->
          IO.puts(device, BoardPresenter.to_string(result))
          {status, result}

        {:error, _} ->
          mark(board, symbol, device)
      end
    end
  end
end
