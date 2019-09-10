defmodule HumanTest do
  use ExUnit.Case
  doctest Human

  defmodule FakeInput do
    def receive_input(list) do
      receive do
        {:io_request, caller, reply_as, {_, _, message}} ->
          case String.contains?(message, "choose") do
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

  test "human cant repeat selection" do
    fake_input = spawn(FakeInput, :receive_input, [["1", "2", "3", "4", "5", "6", "7", "8", "9"]])
    new_board = Board.create(9)

    {:ok, board} = Board.mark(new_board, 1, "x")
    {:ok, board} = Board.mark(board, 2, "x")

    {:ok, should_be} = Board.mark(new_board, 1, "x")

    assert {:ok, board} == Human.mark(should_be, "x", fake_input)
  end

  test "human cant enter out of bounds selection" do
    fake_input =
      spawn(FakeInput, :receive_input, [["0", "99", "1", "2", "3", "4", "5", "6", "7", "8", "9"]])

    new_board = Board.create(9)

    {:ok, board} = Board.mark(new_board, 1, "x")
    {:ok, board} = Board.mark(board, 2, "x")

    {:ok, should_be} = Board.mark(new_board, 1, "x")

    assert {:ok, board} == Human.mark(should_be, "x", fake_input)
  end

  test "human cant enter anything else than a number" do
    fake_input =
      spawn(FakeInput, :receive_input, [["d", "\n", "1", "2", "3", "4", "5", "6", "7", "8", "9"]])

    new_board = Board.create(9)

    {:ok, board} = Board.mark(new_board, 1, "x")

    assert {:ok, board} == Human.mark(new_board, "x", fake_input)
  end
end
