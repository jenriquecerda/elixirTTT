defmodule Player do
  defstruct symbol: nil, marker: nil, device: nil

  def new(symbol, marker, device \\ :stdio) do
    %Player{symbol: symbol, marker: marker, device: device}
  end
end
