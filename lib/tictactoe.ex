defmodule TicTacToe do
  def create_board(size) do
    list = Enum.to_list(1..size)

    Map.new(list, fn x -> {x, nil} end)
  end

  def make_selection(board, player, space) do
    if board[space] != nil do
      raise NonEmptyError, message: "Cell " <> Integer.to_string(space) <> " is not empty."
    end

    updated_board = %{board | space => player.character}

    %{:board => updated_board, :players => nil}
  end

  def current_player([head | tail]) do
    if head.turn == true do
      head
    else
      tail
    end
  end
end

defmodule NonEmptyError do
  defexception message: "Cell already in use."
end
