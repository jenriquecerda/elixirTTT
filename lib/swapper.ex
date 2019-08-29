defmodule Swapper do
  def swap([]) do
    []
  end

  def swap([a, b | tail]) do
    [b, a | swap(tail)]
  end
end
