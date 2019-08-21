defmodule Board do
  defmodule NonEmptyError do
    defexception message: "Space already in use."
  end

  defmodule NonExistingSpace do
    defexception message: "Space already in use."
  end

  def create(size) do
    list = Enum.to_list(1..size)

    Map.new(list, fn x -> {x, nil} end)
  end

  def get(board, space) do
    Map.get(board, space)
  end

  def mark(board, space, mark) do
    if space > size(board) do
      raise NonExistingSpace, message: "Space " <> Integer.to_string(space) <> " does not exist in board."
    end

    if board[space] != nil do
      raise NonEmptyError, message: "Space " <> Integer.to_string(space) <> " is not empty."
    end

    %{board | space => mark}
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
    map_size board
  end
end
