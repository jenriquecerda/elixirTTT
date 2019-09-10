defmodule CPUTest do
  use ExUnit.Case
  doctest CPU

  @board Board.create(9)
  @symbol "X"

  test "marks random space in board" do
    {_, marked_board} = CPU.mark(@board, @symbol)
    assert Enum.count(Board.blank_spaces(marked_board)) == 8
  end

  test "symbol gets randomly marked in board" do
    all_spaces = Board.blank_spaces(@board)

    {_, marked_board} = CPU.mark(@board, @symbol)

    blank_spaces = Board.blank_spaces(marked_board)
    [marked_space] = all_spaces -- blank_spaces
    assert Board.get(marked_board, marked_space) == {:ok, @symbol}
  end
end
