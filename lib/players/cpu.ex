defmodule CPU do
  def choose(board, symbol) do
    selection = Enum.random(Board.nil_spaces(board))

    Player.mark(board, selection, symbol)
  end
end
