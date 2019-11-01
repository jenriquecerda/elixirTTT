defmodule FifoOutputTest do
  use ExUnit.Case
  doctest FifoOutput

  defmodule FakeFifo do
    def output do
      receive do
        {port, {:data, "hello"}} ->
          send(port, {self(), {:data, "world"}})
      end
    end
  end

  @tag :skip
  test "outputs to fifo" do
    # fake_fifo = spawn(FakeFifo, :output, [])

    output = FifoOutput.print('in')

    output.("hello")

    received_output =
      receive do
        {port, {:data, message}} -> message
        true -> "hola"
      end

    assert received_output == "world"
  end
end
