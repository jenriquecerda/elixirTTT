defmodule OutputTest do
  use ExUnit.Case
  doctest Output

  defmodule FakeOutput do
    def output do
      receive do
        {:io_request, caller, reply_as, {_, _, message}} ->
          case String.contains?(message, "test") do
            true ->
              send(caller, {:io_reply, reply_as, "ok"})
          end
      end
    end
  end

  test "outputs to selected device" do
    fake_output = spawn(FakeOutput, :output, [])

    output = fn message, device -> Output.print(message, device) end

    assert output.("test", fake_output) == "ok"
  end
end
