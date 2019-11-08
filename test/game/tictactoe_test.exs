defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  defmodule FakeIO do
    def receive_input do
      receive do
        {:io_request, caller, reply_as, {_, _, message}} ->
          message = String.trim(message)

          cond do
            String.contains?(message, "wins") == true ->
              send(caller, {:message, message})
              send(caller, {:io_reply, reply_as, message})
              receive_input()

            String.contains?(message, "Draw") == true ->
              send(caller, {:message, message})
              send(caller, {:io_reply, reply_as, message})
              receive_input()

            true ->
              send(caller, {:io_reply, reply_as, message})
              receive_input()
          end
      end
    end
  end

  @board Board.create(9)
  @fake_device spawn(FakeIO, :receive_input, [])

  @tag :skip
  test "marks with users selection" do
    players = prepare_players("X", "O")

    output = Output.print(@fake_device)
    updated_board = TicTacToe.play_game(@board, players, NeverWins, output)

    assert Board.is_full?(updated_board)
  end

  @tag :skip
  test "ends when there is a winner" do
    p1 = fn board -> Board.mark(board, 1, "X") end
    p2 = fn board -> CPU.mark(board, "O", &Chooser.choose/1) end

    players = [p1, p2]

    {:ok, board} = Board.mark(Board.create(9), 2, "X")
    {:ok, board} = Board.mark(board, 3, "X")

    {:ok, winner_board} = Board.mark(Board.create(9), 1, "X")
    {:ok, winner_board} = Board.mark(winner_board, 2, "X")
    {:ok, winner_board} = Board.mark(winner_board, 3, "X")

    output = Output.print(@fake_device)
    assert TicTacToe.play_game(board, players, WinsOnTop, output) == winner_board
  end

  @tag :skip
  test "can't play on a board with a winner" do
    players = prepare_players("X", "O")

    {:ok, board} = Board.mark(Board.create(9), 1, "X")
    {:ok, board} = Board.mark(board, 2, "X")
    {:ok, board} = Board.mark(board, 3, "X")

    output = Output.print(@fake_device)
    assert TicTacToe.play_game(board, players, WinsOnTop, output) == board
  end

  @tag :skip
  test "prints draw message" do
    players = prepare_players("X", "O")

    {:ok, board} = Board.mark(Board.create(9), 1, "O")
    {:ok, board} = Board.mark(board, 2, "X")
    {:ok, board} = Board.mark(board, 3, "O")
    {:ok, board} = Board.mark(board, 4, "X")
    {:ok, board} = Board.mark(board, 5, "X")
    {:ok, board} = Board.mark(board, 6, "O")
    {:ok, board} = Board.mark(board, 7, "X")
    {:ok, board} = Board.mark(board, 8, "O")

    output = Output.print(@fake_device)
    TicTacToe.play_game(board, players, NeverWins, output)

    assert String.ends_with?(winning_message(), "Draw") == true
  end

  @tag :skip
  test "prints winners symbols" do
    players = prepare_players("X", "O")

    {:ok, board} = Board.mark(Board.create(9), 1, "X")
    {:ok, board} = Board.mark(board, 2, "X")
    {:ok, board} = Board.mark(board, 3, "X")

    output = Output.print(@fake_device)
    TicTacToe.play_game(board, players, WinsOnTop, output)

    assert String.ends_with?(winning_message(), "Player X wins") == true
  end

  @tag timeout: :infinity
  @tag :skip
  test "CPU never loses with minimax" do
    spawn(TicTacToeTest, :test_game, [self()])
    spawn(TicTacToeTest, :test_game, [self()])
    spawn(TicTacToeTest, :test_game, [self()])
    spawn(TicTacToeTest, :test_game, [self()])
    spawn(TicTacToeTest, :test_game, [self()])
    spawn(TicTacToeTest, :test_game, [self()])
    spawn(TicTacToeTest, :test_game, [self()])

    receive do
      {:done, true} ->
        true
    end
  end

  def test_game(pid) do
    option_one = fn board -> Board.blank_spaces(board) end
    player_one = fn board -> CPU.mark(board, "O", &Chooser.choose/1, option_one) end

    option_two = fn board -> MiniMax.options(&Fake.winner/1, board, ["X", "O"]) end
    player_two = fn board -> CPU.mark(board, "X", &Chooser.choose/1, option_two) end

    players = [player_one, player_two]

    output = fn message -> Output.print(message, @fake_device) end

    for x <- 0..750 do
      board = Board.create(9)
      board = TicTacToe.play_game(board, players, WinningRules, output)
      assert WinningRules.winner(board) != "O"
    end

    send(pid, {:done, true})
  end

  defp prepare_players(symbol_one, symbol_two) do
    options = fn board -> Board.blank_spaces(board) end

    p1 = fn board -> CPU.mark(board, symbol_one, &Chooser.choose/1, options) end
    p2 = fn board -> CPU.mark(board, symbol_two, &Chooser.choose/1, options) end

    [p1, p2]
  end

  defp winning_message do
    receive do
      {:message, msg} ->
        msg
    end
  end
end

defmodule NeverWins do
  def has_winner?(_) do
    false
  end

  def winner(_) do
  end
end

defmodule WinsOnTop do
  def has_winner?(board) do
    {_, x} = Board.get(board, 1)
    {_, y} = Board.get(board, 2)
    {_, z} = Board.get(board, 3)

    x == y && x == z && x != nil
  end

  def winner(_) do
    "X"
  end
end
