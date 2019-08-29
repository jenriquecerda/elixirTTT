defmodule SwapperTest do
  use ExUnit.Case
  doctest TicTacToe

  test "swaps array" do
    characters = ["x", "o"]

    characters = Swapper.swap(characters)
    assert characters == ["o", "x"]

    characters = Swapper.swap(characters)
    assert characters == ["x", "o"]
  end
end
