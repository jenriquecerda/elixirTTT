defmodule CPUTest do
  use ExUnit.Case
  doctest CPU

  @board Board.create(9)
  @symbol "X"

  test "marks random space in board" do
    options = fn board -> Board.blank_spaces(board) end
    {_, marked_board} = CPU.mark(@board, @symbol, &Chooser.choose/1, options)
    assert Enum.count(Board.blank_spaces(marked_board)) == 8
  end

  test "symbol gets randomly marked in board" do
    all_spaces = Board.blank_spaces(@board)

    options = fn board -> Board.blank_spaces(board) end
    {_, marked_board} = CPU.mark(@board, @symbol, &Chooser.choose/1, options)

    blank_spaces = Board.blank_spaces(marked_board)
    [marked_space] = all_spaces -- blank_spaces
    assert Board.get(marked_board, marked_space) == {:ok, @symbol}
  end

  test "marks with minimax" do
    {_, board} = Board.mark(Board.create(9), 1, "O")
    {_, board} = Board.mark(board, 2, "O")
    {_, board} = Board.mark(board, 3, "X")
    {_, board} = Board.mark(board, 4, "X")
    {_, board} = Board.mark(board, 6, "O")
    {_, board} = Board.mark(board, 9, "X")
    all_spaces = Board.blank_spaces(board)

    minimax_options = fn board ->
      MiniMax.options(&Fake.winner/1, board, ["X", "O"])
    end

    {_, marked_board} = CPU.mark(board, @symbol, &Chooser.choose/1, minimax_options)

    blank_spaces = Board.blank_spaces(marked_board)
    [marked_space] = all_spaces -- blank_spaces
    assert Board.get(marked_board, marked_space) == {:ok, @symbol}
  end
end
