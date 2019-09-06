defmodule CPUTest do
  use ExUnit.Case
  doctest CPU

  test "returns random empty seletion" do
    board = Board.create(3)
    player = Player.new("X", nil, nil)

    {:ok, board} = Board.mark(board, 1, "X")

    {:ok, updated_board} = CPU.function(board, player)

    assert Board.get(updated_board, 2) || Board.get(updated_board, 3) == {:ok, nil}
  end
end
