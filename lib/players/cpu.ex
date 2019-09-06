defmodule CPU do
  def function(board, player) do
    empty_spaces = Board.blank_spaces(board)

    space = Enum.random(empty_spaces)

    Board.mark(board, space, player.symbol)
  end
end
