defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  @board Board.create(9)

  test "humans can play" do
    chooser = spawn(FakeInput, :receive_input, [["1", "2", "3", "4", "5", "6", "7", "8", "9"]])

    player_one = Player.new("X", Human, chooser)
    player_two = Player.new("O", Human, chooser)

    players = [player_one, player_two]

    updated_board = TicTacToe.play_game(@board, players)

    assert Board.get(updated_board, 1) == {:ok, "X"}
    assert Board.get(updated_board, 2) == {:ok, "O"}
    assert Board.get(updated_board, 3) == {:ok, "X"}
  end

  # test "cpu can play" do
  #   player_one = Player.new("X", CPU, chooser)
  #   player_two = Player.new("O", CPU, chooser)

  #   players = [player_one, player_two]

  #   updated_board = TicTacToe.play_game(@board, players)

  #   assert Board.is_full?(updated_board) == true
  # end
end

defmodule FakeInput do
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
