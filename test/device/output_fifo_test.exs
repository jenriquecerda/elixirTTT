defmodule FifoOutputTest do
  use ExUnit.Case
  doctest FifoOutput

  test "outputs message to fifo" do
    output = FifoOutput.print("fake_path")

    output.("hello")

    {_, fake_fifo} = File.open("fake_path", [:read])

    {_, received_output} = File.read("fake_path")

    File.close("fake_path")
    File.rm("fake_path")

    assert String.trim(received_output) == "hello"
  end

  test "outputs board to fifo" do
    output = FifoOutput.print("fake_path")

    fake_map = %{
      1 => nil,
      2 => "X",
      3 => "X",
      4 => nil,
      5 => nil,
      6 => nil,
      7 => nil,
      8 => nil,
      9 => nil
    }

    output.(fake_map)

    {_, fake_fifo} = File.open("fake_path", [:read])

    {_, received_output} = File.read("fake_path")

    File.close("fake_path")
    File.rm("fake_path")

    assert String.trim(received_output) == "2-X;3-X;"
  end
end
