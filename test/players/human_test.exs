defmodule HumanTest do
  use ExUnit.Case
  doctest Human

  defmodule FakeInput do
    def receive_input(list) do
      receive do
        {:io_request, caller, reply_as, {_, _, message}} ->
          case String.equivalent?(message, "test") do
            true ->
              {number, list} = List.pop_at(list, 0)
              send(caller, {:io_reply, reply_as, number})
              receive_input(list)

            false ->
              send(caller, {:io_reply, reply_as, message})
              receive_input(list)
          end
      end
    end
  end

  @new_board Board.create(9)

  test "human cant repeat selection" do
    fake_io = spawn(FakeInput, :receive_input, [["1", "2", "3", "4", "5", "6", "7", "8", "9"]])

    {:ok, board} = Board.mark(@new_board, 1, "x")
    {:ok, board} = Board.mark(board, 2, "x")

    {:ok, should_be} = Board.mark(@new_board, 1, "x")

    input = fn ->
      Input.get("test", fake_io) |> String.trim() |> Integer.parse() |> (fn {x, _} -> x end).()
    end

    assert {:ok, board} == Human.mark(should_be, "x", input)
  end

  test "human cant enter out of bounds selection" do
    fake_io =
      spawn(FakeInput, :receive_input, [["0", "99", "1", "2", "3", "4", "5", "6", "7", "8", "9"]])

    {:ok, board} = Board.mark(@new_board, 1, "x")
    {:ok, board} = Board.mark(board, 2, "x")

    {:ok, should_be} = Board.mark(@new_board, 1, "x")

    input = fn ->
      Input.get("test", fake_io) |> String.trim() |> Integer.parse() |> (fn {x, _} -> x end).()
    end

    assert {:ok, board} == Human.mark(should_be, "x", input)
  end
end
