defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  defmodule FakeInput do
    def receive_input(list) do
      receive do
        {:get, caller} ->
          {number, list} = List.pop_at(list, 0)
          send(caller, number)
          receive_input(list)
      end
    end
  end

  @fake_input spawn(FakeInput, :receive_input, [[1, 2, 3, 4, 5, 6, 7, 8, 9]])
  @board Board.create(9)

  test "marks with users selection" do
    player_one = Player.new("X", &fake_chooser/2)
    player_two = Player.new("O", &fake_chooser/2)

    players = [player_one, player_two]

    updated_board = TicTacToe.play_game(@board, players)

    assert Board.is_full(updated_board)
  end

  defp fake_chooser(board, player) do
    send(@fake_input, {:get, self()})

    a =
      receive do
        msg -> msg
      end

    Board.mark(board, a, player.symbol)
  end
end
