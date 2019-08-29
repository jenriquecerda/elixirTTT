defmodule ScreenTest do
  use ExUnit.Case
  doctest Board

  @empty_board Board.create(9)

  test "shows empty board" do
    assert BoardPresenter.to_string(@empty_board) ==
             "     |     |     \n     |     |     \n_____|_____|_____\n     |     |     \n     |     |     \n_____|_____|_____\n     |     |     \n     |     |     \n     |     |     \n"
  end

  test "shows mark on selected space" do
    board = Board.create(9)

    {:ok, board} = Board.mark(board, 1, "x")

    assert BoardPresenter.to_string(board) ==
             "     |     |     \n  x  |     |     \n_____|_____|_____\n     |     |     \n     |     |     \n_____|_____|_____\n     |     |     \n     |     |     \n     |     |     \n"
  end
end
