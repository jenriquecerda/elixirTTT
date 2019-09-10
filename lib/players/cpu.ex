defmodule CPU do
  def mark(board, symbol) do
    empty_spaces = Board.blank_spaces(board)

    space = Enum.random(empty_spaces)

    Board.mark(board, space, symbol)
  end
end
