defmodule ChooserTest do
  use ExUnit.Case
  doctest Chooser

  test "chooses randomly among a list" do
    options = [1, 2, 3]

    selection = Chooser.choose(options)

    case selection do
      1 ->
        assert true

      2 ->
        assert true

      3 ->
        assert true
    end
  end

  test "chooses randomly among a list of tuples" do
    options = [{1, 0}, {2, -1}, {3, 1}]
    assert Chooser.choose(options) == 3

    options = [{1, 0}, {2, -1}, {3, 0}]
    selection = Chooser.choose(options)

    case selection do
      1 ->
        assert true

      3 ->
        assert true
    end
  end
end
