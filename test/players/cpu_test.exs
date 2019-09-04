defmodule CPUTest do
  use ExUnit.Case
  doctest CPU

  @empty_board Board.create(4)

  test "cpu updates board with selection" do
    {:ok, board} = Board.mark(@empty_board, 1, "x")
    {:ok, board} = Board.mark(board, 2, "o")

    {:ok, chosen_board} = CPU.choose(board, "@")

    assert Board.nil_spaces(chosen_board) == [3] || [4]
  end
end
