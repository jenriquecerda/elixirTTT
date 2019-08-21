defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  @empty_board Board.create(3)

  test "it creates empty board" do
    assert Board.get(@empty_board, 1) == nil
    assert Board.get(@empty_board, 2) == nil
    assert Board.get(@empty_board, 3) == nil
  end

  test "it can mark spaces" do
    updated_board = Board.mark(@empty_board, 1, "x")

    assert Board.get(updated_board, 1) == "x"
  end

  test "marked spaces cant be marked again" do
    board = Board.mark(@empty_board, 1, "x")

    assert_raise Board.NonEmptyError, "Space 1 is not empty.", fn -> Board.mark(board, 1, "x") end
  end

  test "it checks if board has empty spaces" do
    assert Board.is_full?(@empty_board) == false

    board = Board.mark(@empty_board, 1, "X")
    board = Board.mark(board, 2, "x")
    board = Board.mark(board, 3, "x")

    assert Board.is_full?(board) == true
  end

  test "it returns board size" do
    assert Board.size(@empty_board) == 3
  end

  test "it only allows spaces in the board" do
    assert_raise Board.NonExistingSpace, "Space 4 does not exist in board.", fn -> Board.mark(@empty_board, 4, "X") end
  end
end
