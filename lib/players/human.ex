defmodule Human do
  def choose(board, symbol, device) do
    {space, _} = IO.gets(device, "Please choose space.\n") |> String.trim() |> Integer.parse()

    {status, result} = Player.mark(board, space, symbol)

    case {status, result} do
      {:ok, _result} ->
        IO.puts(device, BoardPresenter.to_string(result))
        {:ok, result}

      {:error, _result} ->
        choose(board, symbol, device)
    end
  end
end
