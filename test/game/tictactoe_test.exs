defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  @empty_board Board.create(3)
  @players ["x", "o"]

  test "asks for spaces until board is full" do
    fake_IO = spawn(FakeDevice, :receive_input, [["1", "2", "3"]])

    updated_board = TicTacToe.start(@players, @empty_board, fake_IO, FakeScreen)

    assert Board.get(updated_board, 1) == {:ok, "x"}
    assert Board.get(updated_board, 2) == {:ok, "o"}
    assert Board.get(updated_board, 3) == {:ok, "x"}
  end

  test "asks again if chosen space is occupied" do
    fake_IO = spawn(FakeDevice, :receive_input, [["1", "1", "2", "3"]])

    updated_board = TicTacToe.start(@players, @empty_board, fake_IO, FakeScreen)

    assert Board.get(updated_board, 1) == {:ok, "x"}
    assert Board.get(updated_board, 2) == {:ok, "o"}
    assert Board.get(updated_board, 3) == {:ok, "x"}
  end

  test "asks again if chosen space does not exist" do
    fake_IO = spawn(FakeDevice, :receive_input, [["99", "1", "2", "3"]])

    updated_board = TicTacToe.start(@players, @empty_board, fake_IO, FakeScreen)

    assert Board.get(updated_board, 1) == {:ok, "x"}
    assert Board.get(updated_board, 2) == {:ok, "o"}
    assert Board.get(updated_board, 3) == {:ok, "x"}
  end
end

defmodule FakeDevice do
  def receive_input(list) do
    receive do
      {:io_request, caller, reply_as, {_, _, message}} ->
        case String.contains?(message, "Please") do
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

defmodule FakeScreen do
  def to_string(_board) do
  end
end
