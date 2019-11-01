defmodule FifoInputTest do
  use ExUnit.Case
  doctest FifoInput

  test "gets input from fifo" do
    fake_fifo = {:spawn, "echo 3"}

    input = FifoInput.get(fake_fifo)

    assert input.() == 3
  end
end
