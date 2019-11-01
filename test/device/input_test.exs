defmodule InputTest do
  use ExUnit.Case
  doctest Input

  defmodule FakeInput do
    def input do
      receive do
        {:io_request, caller, reply_as, {_, _, message}} ->
          case String.contains?(message, "test") do
            true ->
              send(caller, {:io_reply, reply_as, "ok"})
          end
      end
    end
  end

  test "inputs from selected device" do
    fake_input = spawn(FakeInput, :input, [])

    input = fn message, device -> Input.get(message, device) end

    assert input.("test", fake_input) == "ok"
  end
end
