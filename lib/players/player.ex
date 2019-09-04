defmodule Player do
  defstruct symbol: nil, mode: nil, chooser: nil

  def new(symbol, mode, chooser \\ :stdio) do
    %Player{symbol: symbol, mode: mode, chooser: chooser}
  end

  def mark(board, selection, symbol) do
    {status, result} = Board.mark(board, selection, symbol)
  end
end
