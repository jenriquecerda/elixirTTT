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
  @output spawn(FakeIO, :receive_input, [])

  test "marks with users selection" do
    players = prepare_players("X", "O")

    updated_board = TicTacToe.play_game(@board, players, NeverWins, @output)

    assert Board.is_full?(updated_board)
  end

  test "ends when there is a winner" do
    p1 = fn board -> Board.mark(board, 1, "X") end
    p2 = fn board -> CPU.mark(board, "O") end

    players = [p1, p2]

    {:ok, board} = Board.mark(Board.create(9), 2, "X")
    {:ok, board} = Board.mark(board, 3, "X")

    {:ok, winner_board} = Board.mark(Board.create(9), 1, "X")
    {:ok, winner_board} = Board.mark(winner_board, 2, "X")
    {:ok, winner_board} = Board.mark(winner_board, 3, "X")

    assert TicTacToe.play_game(board, players, WinsOnTop, @output) == winner_board
  end

  test "can't play on a board with a winner" do
    players = prepare_players("X", "O")

    {:ok, board} = Board.mark(Board.create(9), 1, "X")
    {:ok, board} = Board.mark(board, 2, "X")
    {:ok, board} = Board.mark(board, 3, "X")

    assert TicTacToe.play_game(board, players, WinsOnTop, @output) == board
  end

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

    TicTacToe.play_game(board, players, NeverWins, @output)

    assert winning_message() == "Draw"
  end

  test "prints winners symbols" do
    players = prepare_players("X", "O")

    {:ok, board} = Board.mark(Board.create(9), 1, "X")
    {:ok, board} = Board.mark(board, 2, "X")
    {:ok, board} = Board.mark(board, 3, "X")

    TicTacToe.play_game(board, players, WinsOnTop, @output)

    assert winning_message() == "Player X wins"
  end

  defp prepare_players(symbol_one, symbol_two) do
    p1 = fn board -> CPU.mark(board, symbol_one) end
    p2 = fn board -> CPU.mark(board, symbol_two) end

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
