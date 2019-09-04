defmodule HumanTest do
  use ExUnit.Case
  doctest Human

  @empty_board Board.create(9)

  test "human updates board with selection" do
    chooser = spawn(FakeDevice, :receive_input, [["4"]])

    {:ok, board} = Board.mark(@empty_board, 1, "x")
    {:ok, board} = Board.mark(board, 2, "o")

    {:ok, updated_board} = Board.mark(board, 4, "@")

    assert Human.choose(board, "@", chooser) == {:ok, updated_board}
  end

  test "human cant choose unavailable space" do
    chooser = spawn(FakeDevice, :receive_input, [["1", "2"]])

    {:ok, should_be_board} = Board.mark(@empty_board, 1, "x")
    {:ok, should_be_board} = Board.mark(should_be_board, 2, "x")

    {:ok, board} = Board.mark(@empty_board, 1, "x")

    assert Human.choose(board, "x", chooser) == {:ok, should_be_board}
  end
end

defmodule FakeDevice do
  def receive_input(list) do
    receive do
      {:io_request, caller, reply_as, {_, _, message}} ->
        case String.contains?(message, "Please choose space") do
          true ->
            {number, list} = List.pop_at(list, 0)
            send(caller, {:io_reply, reply_as, number})
            receive_input(list)

          false ->
            send(caller, {:io_reply, reply_as, ""})
            receive_input(list)
        end
    end
  end
end
