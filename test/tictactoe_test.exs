defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "it creates empty board" do
    prototpye_board = %{
      1 => nil,
      2 => nil,
      3 => nil
    }

    board = TicTacToe.create_board(3)

    assert prototpye_board == board
  end

  test "player can choose space" do
    player = %Player{character: "X", human: true, turn: true}
    space = 1
    board = TicTacToe.create_board(3)

    updated_board = Map.get(TicTacToe.make_selection(board, player, space), :board)

    assert Map.fetch(updated_board, 1) == {:ok, "X"}
  end

  test "it cant choose occupied space" do
    player = %Player{character: "X", human: true, turn: true}
    space = 1
    board = TicTacToe.create_board(3)

    board = Map.get(TicTacToe.make_selection(board, player, space), :board)

    assert_raise NonEmptyError, "Cell 1 is not empty.", fn ->
      TicTacToe.make_selection(board, player, space)
    end
  end

  test "preserves old board positions" do
    player_one = %Player{character: "X", human: true, turn: true}
    player_two = %Player{character: "O", human: false, turn: true}
    board = TicTacToe.create_board(3)

    updated_board = Map.get(TicTacToe.make_selection(board, player_one, 1), :board)
    updated_board = Map.get(TicTacToe.make_selection(updated_board, player_two, 2), :board)

    assert updated_board == %{1 => "X", 2 => "O", 3 => nil}
  end

  test "it doesnt allow last player to make movement" do
    players = [
      %Player{character: "X", human: true, turn: true},
      %Player{character: "O", human: false}
    ]

    player = TicTacToe.current_player(players)

    assert player.character == "X"
  end
end
