defmodule MiniMaxTest do
  use ExUnit.Case
  doctest MiniMax

  test "returns choosing options with one move left" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "X")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 6, "O")
    {_, marked_board} = Board.mark(marked_board, 7, "X")
    {_, marked_board} = Board.mark(marked_board, 8, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "O")

    assert MiniMax.options(&Fake.winner/1, marked_board, ["X", "O"]) == [{5, 1}]
  end

  test "returns choosing options with two moves left" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "X")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 7, "X")
    {_, marked_board} = Board.mark(marked_board, 8, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "O")

    assert MiniMax.options(&Fake.winner/1, marked_board, ["X", "O"]) == [
             {5, 1},
             {6, -1}
           ]
  end

  test "returns choosing options with two moves left and two nested possibilites" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 5, "O")
    {_, marked_board} = Board.mark(marked_board, 6, "X")
    {_, marked_board} = Board.mark(marked_board, 7, "O")
    {_, marked_board} = Board.mark(marked_board, 8, "X")
    {_, marked_board} = Board.mark(marked_board, 9, "O")

    assert MiniMax.options(&Fake.winner/1, marked_board, ["X", "O"]) == [
             {2, -1},
             {3, 0}
           ]
  end

  test "returns choosing options with three moves left" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "O")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 6, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "X")

    assert MiniMax.options(&Fake.winner/1, marked_board, ["X", "O"]) == [
             {5, 0},
             {7, 1},
             {8, 0}
           ]
  end

  test "returns choosing options with three moves left, new case" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "O")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 5, "X")
    {_, marked_board} = Board.mark(marked_board, 7, "O")
    {_, marked_board} = Board.mark(marked_board, 8, "X")

    assert MiniMax.options(&Fake.winner/1, marked_board, ["X", "O"]) == [
             {4, 0},
             {6, -1},
             {9, -1}
           ]
  end

  test "returns 1 when maximizer wins and only one movement left" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "X")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 6, "O")
    {_, marked_board} = Board.mark(marked_board, 7, "X")
    {_, marked_board} = Board.mark(marked_board, 8, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "O")

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {5, "X", ["X", "O"]}) ==
             %{
               5 => 1
             }
  end

  test "returns -1 when minimizer wins and only one movement left" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "X")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 6, "O")
    {_, marked_board} = Board.mark(marked_board, 7, "X")
    {_, marked_board} = Board.mark(marked_board, 8, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "O")

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {5, "O", ["X", "O"]}) ==
             %{
               5 => -1
             }
  end

  test "returns 0 when draw" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "X")
    {_, marked_board} = Board.mark(marked_board, 3, "O")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 6, "O")
    {_, marked_board} = Board.mark(marked_board, 7, "X")
    {_, marked_board} = Board.mark(marked_board, 8, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "X")

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {5, "O", ["X", "O"]}) ==
             %{
               5 => 0
             }

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {5, "X", ["X", "O"]}) ==
             %{
               5 => 0
             }
  end

  test "returns branch when two spaces left" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "X")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 7, "X")
    {_, marked_board} = Board.mark(marked_board, 8, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "O")

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {5, "X", ["X", "O"]}) ==
             %{
               5 => 1
             }

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {6, "X", ["X", "O"]}) ==
             %{
               6 => [%{5 => -1}]
             }
  end

  test "returns branch when three spaces left" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 7, "X")
    {_, marked_board} = Board.mark(marked_board, 8, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "O")

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {5, "X", ["X", "O"]}) ==
             %{
               5 => 1
             }

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {2, "X", ["X", "O"]}) ==
             %{
               2 => [%{5 => -1}, %{6 => [%{5 => 1}]}]
             }

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {6, "X", ["X", "O"]}) ==
             %{
               6 => [%{2 => [%{5 => 1}]}, %{5 => -1}]
             }
  end

  test "returns branch when three spaces left and two nests" do
    {_, marked_board} = Board.mark(Board.create(9), 1, "O")
    {_, marked_board} = Board.mark(marked_board, 2, "O")
    {_, marked_board} = Board.mark(marked_board, 3, "X")
    {_, marked_board} = Board.mark(marked_board, 4, "X")
    {_, marked_board} = Board.mark(marked_board, 6, "O")
    {_, marked_board} = Board.mark(marked_board, 9, "X")

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {5, "X", ["X", "O"]}) ==
             %{
               5 => [%{7 => [%{8 => 0}]}, %{8 => [%{7 => 1}]}]
             }

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {7, "X", ["X", "O"]}) ==
             %{
               7 => [%{5 => [%{8 => 1}]}, %{8 => [%{5 => 1}]}]
             }

    assert MiniMax.calculate_branch(&Fake.winner/1, marked_board, {8, "X", ["X", "O"]}) ==
             %{
               8 => [%{5 => [%{7 => 1}]}, %{7 => [%{5 => 0}]}]
             }
  end
end

defmodule Fake do
  def winner(board) do
    WinningRules.winner(board)
  end
end
