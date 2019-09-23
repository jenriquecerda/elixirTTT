defmodule CPU do
  def mark(board, symbol, chooser, formula_options) do
    if Enum.count(Board.blank_spaces(board)) == Board.size(board) do
      Board.mark(board, 5, symbol)
    else
      options = formula_options.(board)

      space = chooser.(options)

      Board.mark(board, space, symbol)
    end
  end
end
