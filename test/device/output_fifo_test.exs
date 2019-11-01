defmodule FifoOutputTest do
  use ExUnit.Case
  doctest FifoOutput

  test "outputs to fifo" do
    output = FifoOutput.print("fake_path")

    output.("hello")

    {_, fake_fifo} = File.open("fake_path", [:read])

    {_, received_output} = File.read("fake_path")

    File.close("fake_path")
    File.rm("fake_path")

    assert String.trim(received_output) == "hello"
  end
end
