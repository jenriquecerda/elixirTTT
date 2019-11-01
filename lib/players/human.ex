defmodule Human do
  def mark(board, symbol, input) do
    user_input = input.()

    if user_input == :error do
      mark(board, symbol, input)
    else
      {status, result} = Board.mark(board, user_input, symbol)

      case {status, result} do
        {:ok, result} ->
          {status, result}

        {:error, _} ->
          mark(board, symbol, input)
      end
    end
  end
end
