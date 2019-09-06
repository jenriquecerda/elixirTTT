defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  @empty_board Board.create(3)

  test "creates empty board" do
    assert Board.get(@empty_board, 1) == {:ok, nil}
    assert Board.get(@empty_board, 2) == {:ok, nil}
    assert Board.get(@empty_board, 3) == {:ok, nil}
  end

  test "can mark spaces" do
    {:ok, updated_board} = Board.mark(@empty_board, 1, "x")

    assert Board.get(updated_board, 1) == {:ok, "x"}
  end

  test "marked spaces cant be marked again" do
    {:ok, board} = Board.mark(@empty_board, 1, "x")

    assert Board.mark(board, 1, "x") == {:error, "Space 1 is not empty."}
  end

  test "checks if board has empty spaces" do
    assert Board.is_full(@empty_board) == false

    {:ok, board} = Board.mark(@empty_board, 1, "X")
    {:ok, board} = Board.mark(board, 2, "x")
    {:ok, board} = Board.mark(board, 3, "x")

    assert Board.is_full(board)
  end

  test "returns board size" do
    assert Board.size(@empty_board) == 3
  end

  test "only allows spaces in the board" do
    assert Board.mark(@empty_board, 4, "X") == {:error, "Space 4 does not exist in board."}
  end

  test "returns error when asked for mark on non-existing space" do
    assert Board.get(@empty_board, 4) == {:error, "Space 4 does not exist in board."}
  end

  test "returns nil spaces" do
    {:ok, board} = Board.mark(@empty_board, 2, "x")

    assert Board.blank_spaces(board) == [1, 3]
  end
end
