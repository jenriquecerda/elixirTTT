defmodule ChooserTest do
  use ExUnit.Case
  doctest Chooser

  test "returns cpu function" do
    info = Function.info(Chooser.def_function("cpu"))

    assert info[:module] == CPU
    assert info[:name] == :function
    assert info[:arity] == 2
  end

  test "returns human function" do
    info = Function.info(Chooser.def_function("human"))

    assert info[:module] == Human
    assert info[:name] == :function
    assert info[:arity] == 2
  end
end
