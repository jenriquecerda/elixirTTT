defmodule PlayerTest do
  use ExUnit.Case
  doctest Player

  test "it creates new player" do
    player = Player.new("x", Human, FakeDevice)

    assert player.symbol == "x"
    assert player.mode == Human
    assert player.chooser == FakeDevice
  end
end
