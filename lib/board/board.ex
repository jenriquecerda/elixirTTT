defmodule Board do
  def create(size) do
    list = Enum.to_list(1..size)

    Map.new(list, fn x -> {x, nil} end)
  end

  def get(board, space) do
    if space > size(board) do
      {:error, "Space " <> Integer.to_string(space) <> " does not exist in board."}
    else
      {:ok, Map.get(board, space)}
    end
  end

  def mark(board, space, mark) do
    cond do
      space > size(board) ->
        {:error, "Space " <> Integer.to_string(space) <> " does not exist in board."}

      board[space] != nil ->
        {:error, "Space " <> Integer.to_string(space) <> " is not empty."}

      true ->
        {:ok, %{board | space => mark}}
    end
  end

  def is_full?(board) do
    !Enum.any?(
      board,
      fn {key, value} ->
        value == nil
      end
    )
  end

  def size(board) do
    map_size(board)
  end

  def nil_spaces(board) do
    nil_spaces =
      Enum.map(
        board,
        fn x ->
          {space, _} = x
          {_, mark} = Board.get(board, space)

          if is_nil(mark) do
            space
          else
            nil
          end
        end
      )

    Enum.filter(
      nil_spaces,
      fn x ->
        !is_nil(x)
      end
    )
  end
end
