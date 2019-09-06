defmodule PlayerTest do
  use ExUnit.Case
  doctest Player

  test "it creates new player" do
    player = Player.new("x", &fake_chooser/0)

    assert player.symbol == "x"
    assert player.marker.() == 4
  end

  defp fake_chooser do
    4
  end
end
