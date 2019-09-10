defmodule WinningRulesTest do
  use ExUnit.Case
  doctest WinningRules

  @winner_combinations [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ]

  test "check all combinations are winners" do
    Enum.each(
      @winner_combinations,
      fn combination ->
        x = Board.create(9)
        board = mark_board(x, combination)

        assert WinningRules.has_winner?(board)
      end
    )
  end

  test "returns winner symbol" do
    {:ok, board} = Board.mark(Board.create(9), 1, "O")
    {:ok, board} = Board.mark(board, 2, "O")
    {:ok, board} = Board.mark(board, 3, "O")

    assert WinningRules.winner(board) == "O"
  end

  def mark_board(board, spaces) do
    Enum.reduce(spaces, board, fn space, board ->
      {_, marked_board} = Board.mark(board, space, "X")
      marked_board
    end)
  end
end
